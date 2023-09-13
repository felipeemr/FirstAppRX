import Foundation

let string = "45879890880"
let digits = string.compactMap{ $0.wholeNumberValue }

// calculo do primeiro indice
let primeiroIndice = (digits[0] * 10) +
                     (digits[1] * 9) +
                     (digits[2] * 8) +
                     (digits[3] * 7) +
                     (digits[4] * 6) +
                     (digits[5] * 5) +
                     (digits[6] * 4) +
                     (digits[7] * 3) +
                     (digits[8] * 2)
print (primeiroIndice)
var result1 = (primeiroIndice * 10) % 11
if result1 == 10 { result1 = 0 }
print ( result1)

// calculo segundo indice
let segundoIndice = (digits[0] * 11) +
                    (digits[1] * 10) +
                    (digits[2] * 9) +
                    (digits[3] * 8) +
                    (digits[4] * 7) +
                    (digits[5] * 6) +
                    (digits[6] * 5) +
                    (digits[7] * 4) +
                    (digits[8] * 3) +
                    (digits[9] * 2)
print (segundoIndice)
var result2 = (segundoIndice * 10) % 11
if result2 == 10 { result2 = 0 }
print ( result2)

if result1 == digits[9] && result2 == digits[10]{
    print ("Verdadeiro")
}else {
 print("Falso")
}
