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

const service_selector = document.getElementById('service-selector');
const result = document.getElementById('result-div');

//hide forms
internet_form.style.display = 'none';   
phone_form.style.display = 'none';
lawn_form.style.display = 'none';
mortgage_form.style.display = 'none';
ho_insurance_form.style.display = 'none';
auto_insurance_form.style.display = 'none';


calculate.style.display = 'none';   //hide calc button
result.style.display = 'none';   //hide result

//internet continue
cont.addEventListener('click', () => {
    if (service_selector.value == 'Internet') {
        if (internet_form.style.display === 'none') {
            internet_form.style.display = 'block';    // show the form
            calculate.style.display = 'block';   //show calc button

            //hide other forms
            phone_form.style.display = 'none';
            lawn_form.style.display = 'none';
            mortgage_form.style.display = 'none';
            ho_insurance_form.style.display = 'none';
            auto_insurance_form.style.display = 'none';

            //hide result  
            result.style.display = 'none';  
        }
    }
});

//phone continue
cont.addEventListener('click', () => {
    if (service_selector.value == 'Phone/Cell') {
        if (phone_form.style.display === 'none') {
            phone_form.style.display = 'block';    // show the form
            calculate.style.display = 'block';   //show calc button

            //hide other forms
            internet_form.style.display = 'none';
            lawn_form.style.display = 'none';
            mortgage_form.style.display = 'none';
            ho_insurance_form.style.display = 'none';
            auto_insurance_form.style.display = 'none';

            //hide result
            result.style.display = 'none';  
        }
    }
});

//lawncare continue 
cont.addEventListener('click', () => {
    if (service_selector.value == 'Lawncare') {
        if (lawn_form.style.display === 'none') {
            lawn_form.style.display = 'block';    // show the form
            calculate.style.display = 'block';   //show calc button

            //hide other forms
            internet_form.style.display = 'none';
            phone_form.style.display = 'none';
            mortgage_form.style.display = 'none';
            ho_insurance_form.style.display = 'none';
            auto_insurance_form.style.display = 'none';

            //hide result
            result.style.display = 'none';  
        }
    }
});

//mortgage continue 
cont.addEventListener('click', () => {
    if (service_selector.value == 'Mortgage') {
        if (mortgage_form.style.display === 'none') {
            mortgage_form.style.display = 'block';    // show the form
            calculate.style.display = 'block';   //show calc button

            //hide other forms
            internet_form.style.display = 'none';
            phone_form.style.display = 'none';
            lawn_form.style.display = 'none';
            ho_insurance_form.style.display = 'none';
            auto_insurance_form.style.display = 'none';

            //hide result
            result.style.display = 'none';  
        }
    }
});

//homeowners' insurance continue 
cont.addEventListener('click', () => {
    if (service_selector.value == "Homeowners' Insurance") {
        if (ho_insurance_form.style.display === 'none') {
            ho_insurance_form.style.display = 'block';    // show the form
            calculate.style.display = 'block';   //show calc button

            //hide other forms
            internet_form.style.display = 'none';
            phone_form.style.display = 'none';
            lawn_form.style.display = 'none';
            mortgage_form.style.display = 'none';
            auto_insurance_form.style.display = 'none';

            //hide result
            result.style.display = 'none';  
        }
    }
});

//auto insurance continue
cont.addEventListener('click', () => {
    if (service_selector.value == 'Auto Insurance') {
        if (auto_insurance_form.style.display === 'none') {
            auto_insurance_form.style.display = 'block';    // show the form
            calculate.style.display = 'block';   //show calc button

            //hide other forms
            internet_form.style.display = 'none';
            phone_form.style.display = 'none';
            lawn_form.style.display = 'none';
            mortgage_form.style.display = 'none';
            ho_insurance_form.style.display = 'none';

            //hide result
            result.style.display = 'none';  
        }
    }
});

//internet calculate
calculate.addEventListener('click', () => {
    calculateService(service_selector.value)
});

function calculateService(serviceType) {
    const para = document.createElement("p");
    const node = document.createTextNode("result");
    para.appendChild(node);
    result.appendChild(para);

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