import { createApp } from 'vue';
import App from './App.vue';
import router from './router';

import PrimeVue from 'primevue/config';

import Button from 'primevue/button';

import Chart from 'primevue/chart';

import ConfirmationService from 'primevue/confirmationservice';

import DialogService from 'primevue/dialogservice';

import FileUpload from 'primevue/fileupload';

import InputText from 'primevue/inputtext';



import Sidebar from 'primevue/sidebar';

import Toast from 'primevue/toast';
import ToastService from 'primevue/toastservice';


import '@/assets/styles.scss';

const app = createApp(App);

app.use(router);
app.use(PrimeVue, { ripple: true });
app.use(ToastService);
app.use(DialogService);
app.use(ConfirmationService);





app.component('Button', Button);

app.component('Chart', Chart);

app.component('FileUpload', FileUpload);

app.component('InputText', InputText);

app.component('Sidebar', Sidebar);

app.component('Toast', Toast);


app.mount('#app');
