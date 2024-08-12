import Vue from 'vue';

// ===============Flash Message===============
import FlashMessage from '@smartweb/vue-flash-message';
Vue.use(FlashMessage);

// ===============Simple Vue Validator===============
import SimpleVueValidation from "simple-vue-validator";
const Validator = SimpleVueValidation.Validator;
window.Validator = Validator;
Vue.use(SimpleVueValidation);
