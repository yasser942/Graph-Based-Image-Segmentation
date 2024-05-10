<script setup>
import { useLayout } from '@/layout/composables/layout';
import { computed } from 'vue';

const { layoutConfig } = useLayout();

const logoUrl = computed(() => {
    return '/layout/images/icone-d-image-rouge.png';
});
</script>

<template>
    <div class="layout-footer">
        <img :src="logoUrl" alt="Logo" height="50" class="mr-2" />
        <span class="font-medium ml-2">Image Segmenter</span>
    </div>
</template>
<style lang="scss" scoped></style>
