//establish forms 
const internet_form = document.getElementById('internet-form');
const phone_form = document.getElementById('phone-form');
const lawn_form = document.getElementById('lawn-form');
const mortgage_form = document.getElementById('mortgage-form');
const ho_insurance_form = document.getElementById('HO-insurance-form');
const auto_insurance_form = document.getElementById('auto-insurance-form');

//establish buttons
const cont = document.getElementById('cont');
const calculate = document.getElementById('calculate');

//hide forms
internet_form.style.display = 'none';   
phone_form.style.display = 'none';
lawn_form.style.display = 'none';
mortgage_form.style.display = 'none';
ho_insurance_form.style.display = 'none';
auto_insurance_form.style.display = 'none';

const service_selector = document.getElementById('service-selector');  //establish service selector
const result = document.getElementById('result-div');  //establish result div

calculate.style.display = 'none';   //hide calc button
result.style.display = 'none';   //hide result

//continue button event listener 
cont.addEventListener('click', () => {
    showForm(service_selector.value)
});

//calculate button event listener
calculate.addEventListener('click', () => {
    calculateService(service_selector.value)
});

//show form function
function showForm(serviceType) {

    //hide result  
    result.style.display = 'none';  

    if (serviceType === 'Internet') {
        if (internet_form.style.display === 'none') {
            internet_form.style.display = 'block';    // show the form
            calculate.style.display = 'block';   //show calc button

            //hide other forms
            phone_form.style.display = 'none';
            lawn_form.style.display = 'none';
            mortgage_form.style.display = 'none';
            ho_insurance_form.style.display = 'none';
            auto_insurance_form.style.display = 'none';
        }
    } else if (serviceType === 'Phone/Cell') {
        if (phone_form.style.display === 'none') {
            phone_form.style.display = 'block';    // show the form
            calculate.style.display = 'block';   //show calc button

            //hide other forms
            internet_form.style.display = 'none';
            lawn_form.style.display = 'none';
            mortgage_form.style.display = 'none';
            ho_insurance_form.style.display = 'none';
            auto_insurance_form.style.display = 'none';
        }
    } else if (serviceType === 'Lawncare') {
        if (lawn_form.style.display === 'none') {
            lawn_form.style.display = 'block';    // show the form
            calculate.style.display = 'block';   //show calc button

            //hide other forms
            internet_form.style.display = 'none';
            phone_form.style.display = 'none';
            mortgage_form.style.display = 'none';
            ho_insurance_form.style.display = 'none';
            auto_insurance_form.style.display = 'none'; 
        }
    } else if (serviceType === 'Mortgage') {
        if (mortgage_form.style.display === 'none') {
            mortgage_form.style.display = 'block';    // show the form
            calculate.style.display = 'block';   //show calc button

            //hide other forms
            internet_form.style.display = 'none';
            phone_form.style.display = 'none';
            lawn_form.style.display = 'none';
            ho_insurance_form.style.display = 'none';
            auto_insurance_form.style.display = 'none';
        }
    } else if (serviceType === "Homeowners' Insurance") {
        if (ho_insurance_form.style.display === 'none') {
            ho_insurance_form.style.display = 'block';    // show the form
            calculate.style.display = 'block';   //show calc button

            //hide other forms
            internet_form.style.display = 'none';
            phone_form.style.display = 'none';
            lawn_form.style.display = 'none';
            mortgage_form.style.display = 'none';
            auto_insurance_form.style.display = 'none';
        }
    } else if (serviceType === 'Auto Insurance') {
        if (auto_insurance_form.style.display === 'none') {
            auto_insurance_form.style.display = 'block';    // show the form
            calculate.style.display = 'block';   //show calc button

            //hide other forms
            internet_form.style.display = 'none';
            phone_form.style.display = 'none';
            lawn_form.style.display = 'none';
            mortgage_form.style.display = 'none';
            ho_insurance_form.style.display = 'none';
        }
    } else {
        console.log('ERROR: Service Not Recognized');
    }
}

//calculate function
function calculateService(serviceType) {
    const resultPara = document.getElementById("result-para");

    if (result.style.display === 'none') {
        result.style.display = 'block';    // SHOW the result
    }
}



// downpayment 
// purchase price - downpayment = loan
// interest rate or credit score
// term (length of time 10, 15, 20, 30)
// 
// vendors would be banks
// loan fees (3-10k)