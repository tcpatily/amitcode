const { createApp, ref } = Vue;

createApp({
  setup() {
    const traveller = ref({
      firstName: '',
      lastName: '',
      email: '',
      passport: ''
    });

    const errors = ref({
      firstName: '',
      lastName: '',
      email: '',
      passport: ''
    });

    const validateFirstName = () => {
      const pattern = /^[A-Za-z\s]+$/;
      if (!traveller.value.firstName.trim()) {
        errors.value.firstName = 'First name is required.';
      } else if (!pattern.test(traveller.value.firstName)) {
        errors.value.firstName = 'Only letters are allowed.';
      } else {
        errors.value.firstName = '';
      }
    };

    const validateLastName = () => {
      const pattern = /^[A-Za-z\s]+$/;
      if (!traveller.value.lastName.trim()) {
        errors.value.lastName = 'Last name is required.';
      } else if (!pattern.test(traveller.value.lastName)) {
        errors.value.lastName = 'Only letters are allowed.';
      } else {
        errors.value.lastName = '';
      }
    };

    const validateEmail = () => {
      const pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      errors.value.email = pattern.test(traveller.value.email)
        ? ''
        : 'Enter a valid email.';
    };

    const validatePassport = () => {
      const pattern = /^[A-Z0-9]{6,9}$/i;
      const value = traveller.value.passport;
      if (!value.trim()) {
        errors.value.passport = 'Passport number is required.';
      } else if (!pattern.test(value)) {
        errors.value.passport = 'Only letters and numbers allowed.';
      } else if (value.length < 6 || value.length > 9) {
        errors.value.passport = 'Passport must be 6–9 characters.';
      } else {
        errors.value.passport = '';
      }
    };

    const submitData = () => {
      validateFirstName();
      validateLastName();
      validateEmail();
      validatePassport();

      const hasErrors = Object.values(errors.value).some(err => err !== '');
      if (!hasErrors) {
        console.log('Submitted Traveller Info:', { ...traveller.value });
      } else {
        console.log('Please fix validation errors before submitting.');
      }
    };

    return {
      traveller,
      errors,
      validateFirstName,
      validateLastName,
      validateEmail,
      validatePassport,
      submitData
    };
  }
}).mount('#app');
