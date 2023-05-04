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
    const resultPara = document.getElementById("result-para");   // get result paragraph
    userScore = 0;   // user score for calculation
    
    if (serviceType === "Internet") {
        // get form values
        const numDevices = document.getElementById("num-devices").value;
        const gamesInput = document.getElementById("games-selector").value;
        const streamInput = document.getElementById("stream-selector").value;
        const workInput = document.getElementById("work-selector").value;

        internetInputs = [gamesInput, streamInput, workInput];

        for (let i = 0; i < internetInputs.length; i++) {
            if (internetInputs[i] === "Yes") {
                userScore += 1;
            }
        }

        if (numDevices > 4) {
            userScore += 3;
        } else if (numDevices > 2) {
            userScore += 2;
        } else if (numDevices > 1) {
            userScore += 1;
        } 

        if (userScore > 5) {
            resultPara.innerHTML = "We recommend you get an internet plan with 1GB of download";
        } else if (userScore > 3) {
            resultPara.innerHTML = "We recommend you get an internet plan with 250mb of download";
        } else if (userScore > 1) {
            resultPara.innerHTML = "We recommend you get an internet plan with 100mb of download";
        } else {
            resultPara.innerHTML = "We recommend you get an internet plan with 50mb of download";
        }

        userScore = 0;  // reset userScore

    } else if (serviceType === "Phone/Cell") {
        // get form values
        const covType = document.getElementById("coverage-selector").value;
        const dataInput = document.getElementById("data-selector").value;

        if (covType === "Yes") {
            if (dataInput === "Very Often") {
                resultPara.innerHTML = "We recommend you get a cell plan that allows international calling and has 20GB of roaming data";
            } else if (dataInput === "Somewhat Often") {
                resultPara.innerHTML = "We recommend you get a cell plan that allows international calling and has 10GB of roaming data";
            } else if (dataInput === "Rarely") {
                resultPara.innerHTML = "We recommend you get a cell plan that allows international calling and has 5GB of roaming data";
            }

        } else {
            if (dataInput === "Very Often") {
                resultPara.innerHTML = "We recommend you get a cell plan that has 20GB of roaming data, you do not need to pay extra for international calling";
            } else if (dataInput === "Somewhat Often") {
                resultPara.innerHTML = "We recommend you get a cell plan that has 10GB of roaming data, you do not need to pay extra for international calling";
            } else if (dataInput === "Rarely") {
                resultPara.innerHTML = "We recommend you get a cell plan that has 5GB of roaming data, you do not need to pay extra for international calling";
            }
        } 
    } else if (serviceType === "Lawncare") {
        const sqFeet = document.getElementById("sq-feet").value;
        const freqInput = document.getElementById("last-work-selector").value;

        //  sq feet calc
        if (Number(sqFeet) > 70000) {
            userScore += 3;
        } else if (Number(sqFeet) > 50,000) {
            userScore += 2;
        } else if (Number(sqFeet) > 30,000) {
            userScore += 1;
        } else if (Number(sqFeet) > 15,000) {
            userScore += 0;
        } else if (Number(sqFeet) < 10,000) {
            userScore -= 1;
        }

        //  freq calc
        if (freqInput === "More Than 4 Weeks Ago") {
            userScore += 3;
        } else if (freqInput === "2-4 Weeks Ago") {
            userScore += 2;
        } else if (freqInput === "Less Than 2 Weeks Ago") {
            userScore += 1;
        } 

        //  user score calc
        if (userScore > 5) {
            resultPara.innerHTML = "look for a more professional service that has multiple workers and lots of equipment";
        } else if (userScore > 3) {
            resultPara.innerHTML = "try to find a moderatly professional service with two or more workers and decent equipment";
        } else if (userScore > 1) {
            resultPara.innerHTML = "look for a cheap service, one person and minimal equipment should do the trick";
        } else {
            resultPara.innerHTML = "hire the nieghbor's kid";
        }

        userScore = 0;
    } else if (serviceType === "Mortgage") {
        const homePrice = document.getElementById("home-price").value;
        const downPayment = document.getElementById("down-payment").value;
        const credit = document.getElementById("credit").value;
        const term = document.getElementById("term-selector").value;

        remainingPayment = homePrice - downPayment;

        if(remainingPayment < 0) {
            resultPara.innerHTML = "your downpayment cannot be more than your home price"
        } else {
            if (term === "ASAP") {
                resultPara.innerHTML = "You want to pay off your house ASAP, go for a 10 year term.";
            } else if (term === "I can wait a medium amount of time") {
                resultPara.innerHTML = "You want to pay off your house in a medium amount of time, go for a 15 or 20 year term.";
            } else if (term === "I can wait a long time") {
                resultPara.innerHTML = "You can wait a long time, go for a 30 year term.";
            }

            if (credit > 670) {
                resultPara.innerHTML += " Your credit is good, look for low loan fees and interest rates";
            } else {
                resultPara.innerHTML += " Your credit is poor, expect higher loan fees and interest rates";
            }
        }
    } else if (serviceType === "Homeowners' Insurance") {
        const ownRent = document.getElementById("own-rent-selector").value;
        const credit = document.getElementById("HO-credit").value;

        

    }

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