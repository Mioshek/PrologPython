vec = [4,75,2,74,13,46,1,2,32,2,4,463,100,53,24,2424,91,72,702,24,40,44,5632,64,64,93,2,32,333,23,99,313,122,8,53,56,1,8,92,4,44]
twoDigigNumbers = []
oneDigitNubmers = []
for element in vec:
    if (element > 9 and element < 100):
        twoDigigNumbers.append(element)

    if (element > 0 and element < 10):
        oneDigitNubmers.append(element)

twoDigigNumbers.sort()

result = []
i = 0

oneDigitNubmers = set(oneDigitNubmers)
oneDigitNubmers = list(oneDigitNubmers)
oneDigitNubmers.sort()
oneDigitNubmers = oneDigitNubmers[-3:]
print(oneDigitNubmers)

while (len(result) < 4):
    n = twoDigigNumbers[i]
    if (n not in result and n % oneDigitNubmers[0] == 0 and n % oneDigitNubmers[1] == 0 and n % oneDigitNubmers[2] ==  0):
        result.append(twoDigigNumbers[i])
    i+=1

print(result)