import Foundation

// These files should be in the program's working folder.
let fileNames = [
    "Unit2-07-set1.txt",
    "Unit2-07-set2.txt",
    "Unit2-07-set3.txt"
]

// Read each file and show its statistics.
func main() {
    for fileName in fileNames {
        analyzeFile(fileName)
    }
}

// Read the integers, sort them, and print their statistics.
func analyzeFile(_ fileName: String) {
    let text: String
    do {
        text = try String(contentsOfFile: fileName, encoding: .utf8)
    } catch {
        print("Could not read \(fileName): \(error.localizedDescription)")
        return
    }

    var numberList: [Int] = []

    // Split on spaces and line breaks, then add each value to the list.
    for value in text.split(whereSeparator: { $0.isWhitespace }) {
        guard let number = Int(String(value)) else {
            print("Invalid integer in \(fileName): \(value)")
            return
        }
        numberList.append(number)
    }

    // Mean and median need at least one value.
    guard !numberList.isEmpty else {
        print("No integers found in \(fileName)")
        return
    }

    // A Swift array can grow like a list, so sorting makes a new array.
    let numbers = numberList.sorted()

    print(fileName)
    print("Mean: \(mean(numbers))")
    print("Median: \(median(numbers))")
    print()
}

// Add the values and divide by how many there are.
func mean(_ numbers: [Int]) -> Double {
    let sum = numbers.reduce(0.0) { $0 + Double($1) }
    return sum / Double(numbers.count)
}

// Find the middle value, or average the two middle values.
func median(_ numbers: [Int]) -> Double {
    let middle = numbers.count / 2

    if numbers.count % 2 == 1 {
        return Double(numbers[middle])
    }

    return (Double(numbers[middle - 1]) + Double(numbers[middle])) / 2
}

main()
