const readline = require('readline')
const readlineInterface = readline.createInterface({
    input: process.stdin,
    output: process.stdout
})

const computeCircleArea = (radius) => (Math.PI * radius ** 2).toFixed(3);

const isPositiveNumber = (number) => !isNaN(number) && number > 0;

readlineInterface.question("Введите радиус круга: ", (value) => {
    const radius = parseFloat(value);
    if (isPositiveNumber(radius)) {
        console.log(computeCircleArea(radius))
    } else {
        console.error("Некорректный радиус!")
    }
    readlineInterface.close()
})