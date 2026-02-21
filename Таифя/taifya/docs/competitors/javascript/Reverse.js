const readline = require('readline');
const readlineInterface = readline.createInterface({
    input: process.stdin,
    output: process.stdout
})

readlineInterface.question("Введите строку: ", (value) => {
    const reversedString = value.trim().split('').reverse().join('');
    console.log(reversedString);
    readlineInterface.close()
})