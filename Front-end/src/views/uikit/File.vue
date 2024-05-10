<template>
  <div class="grid">
    <div class="col-12">
      <div class="card">
        <h5>Please upload your image to segment</h5>
        <FileUpload
          name="demo[]"
          @uploader="onUpload"
          :multiple="true"
          accept="image/*"
          :maxFileSize="1000000"
          customUpload
        />
      </div>
    </div>
    <div class="col-12">
      <div v-if="imageData" class="card">
        <h5>Result</h5>
        <div  class="card flex justify-content-center">
        <img :src="imageData" alt="Analyzed Image" class="w-full md:w-30rem" />
      </div>
        </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";
import axios from 'axios';
import { useToast } from 'primevue/usetoast';

const toast = useToast();

const imageData = ref(null); // New reactive variable to hold the image data

const onUpload = async (event) => {
  const formData = new FormData();
  formData.append('image', event.files[0]);

  try {
    const response = await axios.post('http://192.168.1.115:5001/segment', formData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      },
      // Tell Axios to treat the response as binary data
      responseType: 'arraybuffer'
    });

    const imageBlob = new Blob([response.data]); // Create a Blob from the response data
    const imageUrl = URL.createObjectURL(imageBlob); // Create a URL for the Blob

    imageData.value = imageUrl; // Set the image URL

    toast.add({
      severity: 'success',
      summary: 'Success',
      detail: 'Image successfully analyzed!',
      life: 10000
    });
  } catch (error) {
    console.error('Error:', error);

    if (error.response) {
      console.error('Response Data:', error.response.data);
      console.error('Response Status:', error.response.status);
      console.error('Response Headers:', error.response.headers);
    }

    toast.add({
      severity: 'error',
      summary: 'Error',
      detail: 'An error occurred while analyzing the image. Please try again.',
      life: 10000
    });
  }
};
</script>
