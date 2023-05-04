const calc = document.getElementById("calc");

//calculate button event listener
calc.addEventListener('click', () => {
    calculateAffordability()
});

function calculateAffordability() {
    const service = document.getElementById("service-selector").value;
    const price = document.getElementById("pay").value;
    const income = document.getElementById("income").value;
    const resultPara = document.getElementById("result-para");

    if (service === "Mortgage") {
        if (Number(price)/Number(income) < 0.25) {
            resultPara.innerHTML = "You are spending less than 25% of your income on your mortgage, you can afford to increase this to 25%-35%";
        } else if (Number(price)/Number(income) > 0.4) {
            resultPara.innerHTML = "You are spending over 40% of your income on your mortgage, you may want to decrease this to 25%-35%";
        } else {
            resultPara.innerHTML = "You can afford your current mortgage";
        }
    } else if (service === "Internet" || service === "Phone/Cell" || service === "Lawncare") {
        if (Number(price)/Number(income) < 0.01) {
            resultPara.innerHTML = "You are spending less than 1% of your income on this service, you can afford to increase that to 1.25%-1.5%";
        } else if (Number(price)/Number(income) > 0.02) {
            resultPara.innerHTML = "You are spending over 2% of your income on this service, you may want to decrease this to to 1.25%-1.5%";
        } else {
            resultPara.innerHTML = "You can afford your current service";
        }
    } else if (service === "Homeowners' Insurance" || service === "Auto Insurance") {
        if (Number(price)/Number(income) < 0.05) {
            resultPara.innerHTML = "You are spending less than 5% of your income on this service, you can afford to increase this to 5%-7%";
        } else if (Number(price)/Number(income) > 0.1) {
            resultPara.innerHTML = "You are spending over 10% of your income on your mortgage, you may want to decrease this to 5%-7%";
        } else {
            resultPara.innerHTML = "You can afford your current service";
        }
    }
}
