//
//  QuizService.swift
//  QuizVerse
//

import Foundation

class QuizService {
    static let shared = QuizService()
    
    private init() {}
    
    func getAllQuizzes() -> [Quiz] {
        return [
            createSpaceQuiz(),
            createTechnologyQuiz(),
            createArtQuiz(),
            createScienceQuiz(),
            createHistoryQuiz(),
            createNatureQuiz(),
            createMathematicsQuiz(),
            createLiteratureQuiz()
        ]
    }
    
    private func createSpaceQuiz() -> Quiz {
        let questions = [
            Question(
                text: "What is the largest planet in our solar system?",
                options: ["Earth", "Jupiter", "Saturn", "Neptune"],
                correctAnswerIndex: 1,
                explanation: "Jupiter is the largest planet in our solar system, with a mass more than twice that of all other planets combined.",
                points: 10
            ),
            Question(
                text: "How long does it take light from the Sun to reach Earth?",
                options: ["8 seconds", "8 minutes", "8 hours", "8 days"],
                correctAnswerIndex: 1,
                explanation: "Light travels at approximately 299,792 km/s, taking about 8 minutes and 20 seconds to travel from the Sun to Earth.",
                points: 15
            ),
            Question(
                text: "Which planet is known as the Red Planet?",
                options: ["Venus", "Mars", "Mercury", "Jupiter"],
                correctAnswerIndex: 1,
                explanation: "Mars appears reddish due to iron oxide (rust) on its surface, earning it the nickname 'Red Planet'.",
                points: 10
            ),
            Question(
                text: "What is a light-year?",
                options: ["Time light takes to travel one year", "Distance light travels in one year", "The age of light", "The weight of light"],
                correctAnswerIndex: 1,
                explanation: "A light-year is the distance light travels in one year, approximately 9.46 trillion kilometers.",
                points: 15
            ),
            Question(
                text: "Which galaxy is closest to the Milky Way?",
                options: ["Andromeda", "Triangulum", "Whirlpool", "Sombrero"],
                correctAnswerIndex: 0,
                explanation: "The Andromeda Galaxy is approximately 2.5 million light-years away and is on a collision course with the Milky Way.",
                points: 20
            )
        ]
        
        return Quiz(
            title: "Space Odyssey",
            description: "Journey through the cosmos and discover the mysteries of our universe",
            category: .space,
            difficulty: .medium,
            questions: questions,
            icon: "sparkles",
            estimatedTime: 5
        )
    }
    
    private func createTechnologyQuiz() -> Quiz {
        let questions = [
            Question(
                text: "What does CPU stand for?",
                options: ["Central Processing Unit", "Computer Personal Unit", "Central Program Utility", "Computational Processing Unit"],
                correctAnswerIndex: 0,
                explanation: "CPU stands for Central Processing Unit, the primary component that executes instructions in a computer.",
                points: 10
            ),
            Question(
                text: "In what year was the first iPhone released?",
                options: ["2005", "2006", "2007", "2008"],
                correctAnswerIndex: 2,
                explanation: "The first iPhone was released on June 29, 2007, revolutionizing the smartphone industry.",
                points: 10
            ),
            Question(
                text: "What programming language is primarily used for iOS development?",
                options: ["Java", "Python", "Swift", "C++"],
                correctAnswerIndex: 2,
                explanation: "Swift is Apple's primary programming language for iOS, macOS, watchOS, and tvOS development.",
                points: 15
            ),
            Question(
                text: "What does RAM stand for?",
                options: ["Random Access Memory", "Rapid Access Module", "Read And Modify", "Runtime Application Memory"],
                correctAnswerIndex: 0,
                explanation: "RAM (Random Access Memory) is a form of computer memory that can be read and changed in any order.",
                points: 10
            ),
            Question(
                text: "Which company developed the Android operating system?",
                options: ["Apple", "Microsoft", "Google", "Samsung"],
                correctAnswerIndex: 2,
                explanation: "Android was developed by Android Inc., which Google purchased in 2005.",
                points: 10
            )
        ]
        
        return Quiz(
            title: "Tech Frontier",
            description: "Test your knowledge of modern technology and computing",
            category: .technology,
            difficulty: .easy,
            questions: questions,
            icon: "cpu",
            estimatedTime: 4
        )
    }
    
    private func createArtQuiz() -> Quiz {
        let questions = [
            Question(
                text: "Who painted the Mona Lisa?",
                options: ["Vincent van Gogh", "Leonardo da Vinci", "Pablo Picasso", "Michelangelo"],
                correctAnswerIndex: 1,
                explanation: "Leonardo da Vinci painted the Mona Lisa between 1503 and 1519. It's one of the most famous paintings in the world.",
                points: 10
            ),
            Question(
                text: "Which art movement is Salvador Dalí associated with?",
                options: ["Impressionism", "Cubism", "Surrealism", "Expressionism"],
                correctAnswerIndex: 2,
                explanation: "Salvador Dalí was a prominent Spanish Surrealist artist known for his technical skill and striking imagery.",
                points: 15
            ),
            Question(
                text: "Where is the original 'The Starry Night' painting displayed?",
                options: ["The Louvre", "Museum of Modern Art", "British Museum", "Uffizi Gallery"],
                correctAnswerIndex: 1,
                explanation: "Vincent van Gogh's 'The Starry Night' has been in the permanent collection of MoMA in New York since 1941.",
                points: 20
            ),
            Question(
                text: "What primary colors are used in traditional color theory?",
                options: ["Red, Green, Blue", "Red, Yellow, Blue", "Cyan, Magenta, Yellow", "Red, Orange, Yellow"],
                correctAnswerIndex: 1,
                explanation: "In traditional color theory, red, yellow, and blue are considered primary colors from which all other colors can be mixed.",
                points: 10
            ),
            Question(
                text: "Which artist is famous for the 'drip painting' technique?",
                options: ["Jackson Pollock", "Mark Rothko", "Andy Warhol", "Roy Lichtenstein"],
                correctAnswerIndex: 0,
                explanation: "Jackson Pollock was famous for his unique 'drip painting' technique, a form of abstract expressionism.",
                points: 15
            )
        ]
        
        return Quiz(
            title: "Artistic Expressions",
            description: "Explore the world of art, artists, and creative movements",
            category: .art,
            difficulty: .medium,
            questions: questions,
            icon: "paintpalette",
            estimatedTime: 5
        )
    }
    
    private func createScienceQuiz() -> Quiz {
        let questions = [
            Question(
                text: "What is the chemical symbol for gold?",
                options: ["Go", "Gd", "Au", "Ag"],
                correctAnswerIndex: 2,
                explanation: "The symbol Au comes from the Latin word 'aurum', meaning gold.",
                points: 10
            ),
            Question(
                text: "What is the speed of light in vacuum?",
                options: ["299,792 km/s", "199,792 km/s", "399,792 km/s", "99,792 km/s"],
                correctAnswerIndex: 0,
                explanation: "The speed of light in vacuum is exactly 299,792,458 meters per second, approximately 299,792 km/s.",
                points: 15
            ),
            Question(
                text: "What is the most abundant gas in Earth's atmosphere?",
                options: ["Oxygen", "Carbon Dioxide", "Nitrogen", "Hydrogen"],
                correctAnswerIndex: 2,
                explanation: "Nitrogen makes up about 78% of Earth's atmosphere, while oxygen accounts for about 21%.",
                points: 10
            ),
            Question(
                text: "What is the powerhouse of the cell?",
                options: ["Nucleus", "Mitochondria", "Ribosome", "Chloroplast"],
                correctAnswerIndex: 1,
                explanation: "Mitochondria are known as the powerhouse of the cell because they generate most of the cell's ATP energy.",
                points: 10
            ),
            Question(
                text: "What is the pH value of pure water?",
                options: ["5", "7", "9", "11"],
                correctAnswerIndex: 1,
                explanation: "Pure water has a pH of 7, which is considered neutral on the pH scale.",
                points: 10
            ),
            Question(
                text: "What phenomenon causes the Northern Lights?",
                options: ["Ice crystals", "Solar particles", "Moonlight reflection", "Cloud formations"],
                correctAnswerIndex: 1,
                explanation: "The Aurora Borealis (Northern Lights) occurs when charged particles from the Sun interact with Earth's magnetic field.",
                points: 20
            )
        ]
        
        return Quiz(
            title: "Scientific Discoveries",
            description: "Dive into the fundamental principles of science and nature",
            category: .science,
            difficulty: .medium,
            questions: questions,
            icon: "atom",
            estimatedTime: 6
        )
    }
    
    private func createHistoryQuiz() -> Quiz {
        let questions = [
            Question(
                text: "In which year did World War II end?",
                options: ["1943", "1944", "1945", "1946"],
                correctAnswerIndex: 2,
                explanation: "World War II ended in 1945 with Germany's surrender in May and Japan's surrender in August.",
                points: 10
            ),
            Question(
                text: "Who was the first President of the United States?",
                options: ["Thomas Jefferson", "George Washington", "John Adams", "Benjamin Franklin"],
                correctAnswerIndex: 1,
                explanation: "George Washington served as the first President of the United States from 1789 to 1797.",
                points: 10
            ),
            Question(
                text: "What ancient wonder is still standing today?",
                options: ["Hanging Gardens of Babylon", "Colossus of Rhodes", "Great Pyramid of Giza", "Lighthouse of Alexandria"],
                correctAnswerIndex: 2,
                explanation: "The Great Pyramid of Giza is the only one of the Seven Wonders of the Ancient World still in existence.",
                points: 15
            ),
            Question(
                text: "In which year did the Berlin Wall fall?",
                options: ["1987", "1988", "1989", "1990"],
                correctAnswerIndex: 2,
                explanation: "The Berlin Wall fell on November 9, 1989, marking a pivotal moment in the end of the Cold War.",
                points: 15
            ),
            Question(
                text: "Who was the first person to set foot on the Moon?",
                options: ["Buzz Aldrin", "Neil Armstrong", "Yuri Gagarin", "John Glenn"],
                correctAnswerIndex: 1,
                explanation: "Neil Armstrong became the first human to walk on the Moon on July 20, 1969, during the Apollo 11 mission.",
                points: 10
            )
        ]
        
        return Quiz(
            title: "Historical Chronicles",
            description: "Travel through time and explore significant historical events",
            category: .history,
            difficulty: .easy,
            questions: questions,
            icon: "book.closed",
            estimatedTime: 5
        )
    }
    
    private func createNatureQuiz() -> Quiz {
        let questions = [
            Question(
                text: "What is the largest living organism on Earth?",
                options: ["Blue Whale", "Giant Sequoia", "Honey Fungus", "Great Barrier Reef"],
                correctAnswerIndex: 2,
                explanation: "The Armillaria ostoyae (honey fungus) in Oregon's Blue Mountains covers 2,384 acres and is over 2,000 years old.",
                points: 20
            ),
            Question(
                text: "How many hearts does an octopus have?",
                options: ["1", "2", "3", "4"],
                correctAnswerIndex: 2,
                explanation: "Octopuses have three hearts: two pump blood to the gills, while the third pumps it to the rest of the body.",
                points: 15
            ),
            Question(
                text: "What is the fastest land animal?",
                options: ["Lion", "Cheetah", "Leopard", "Gazelle"],
                correctAnswerIndex: 1,
                explanation: "The cheetah can reach speeds up to 70 mph (112 km/h), making it the fastest land animal.",
                points: 10
            ),
            Question(
                text: "Which tree produces acorns?",
                options: ["Pine", "Maple", "Oak", "Birch"],
                correctAnswerIndex: 2,
                explanation: "Oak trees produce acorns, which are an important food source for many wildlife species.",
                points: 10
            ),
            Question(
                text: "What percentage of Earth's surface is covered by water?",
                options: ["51%", "61%", "71%", "81%"],
                correctAnswerIndex: 2,
                explanation: "Approximately 71% of Earth's surface is covered by water, with the majority being ocean water.",
                points: 10
            )
        ]
        
        return Quiz(
            title: "Nature's Wonders",
            description: "Discover the incredible diversity of life on our planet",
            category: .nature,
            difficulty: .medium,
            questions: questions,
            icon: "leaf",
            estimatedTime: 5
        )
    }
    
    private func createMathematicsQuiz() -> Quiz {
        let questions = [
            Question(
                text: "What is the value of π (pi) to two decimal places?",
                options: ["3.12", "3.14", "3.16", "3.18"],
                correctAnswerIndex: 1,
                explanation: "Pi (π) is approximately 3.14159, which rounds to 3.14 when expressed to two decimal places.",
                points: 10
            ),
            Question(
                text: "What is the next prime number after 7?",
                options: ["9", "10", "11", "13"],
                correctAnswerIndex: 2,
                explanation: "11 is the next prime number after 7. Prime numbers are only divisible by 1 and themselves.",
                points: 10
            ),
            Question(
                text: "What is the square root of 144?",
                options: ["10", "11", "12", "13"],
                correctAnswerIndex: 2,
                explanation: "12 × 12 = 144, so the square root of 144 is 12.",
                points: 10
            ),
            Question(
                text: "In a right triangle, what is the relationship described by the Pythagorean theorem?",
                options: ["a + b = c", "a² + b² = c²", "a × b = c", "a² - b² = c²"],
                correctAnswerIndex: 1,
                explanation: "The Pythagorean theorem states that in a right triangle, a² + b² = c², where c is the hypotenuse.",
                points: 15
            ),
            Question(
                text: "What is the sum of angles in a triangle?",
                options: ["90 degrees", "180 degrees", "270 degrees", "360 degrees"],
                correctAnswerIndex: 1,
                explanation: "The sum of all interior angles in any triangle always equals 180 degrees.",
                points: 10
            ),
            Question(
                text: "What is 15% of 200?",
                options: ["25", "30", "35", "40"],
                correctAnswerIndex: 1,
                explanation: "15% of 200 is calculated as (15/100) × 200 = 30.",
                points: 10
            )
        ]
        
        return Quiz(
            title: "Mathematical Mastery",
            description: "Challenge your mind with mathematical concepts and problem-solving",
            category: .mathematics,
            difficulty: .easy,
            questions: questions,
            icon: "function",
            estimatedTime: 6
        )
    }
    
    private func createLiteratureQuiz() -> Quiz {
        let questions = [
            Question(
                text: "Who wrote 'Romeo and Juliet'?",
                options: ["Charles Dickens", "William Shakespeare", "Jane Austen", "Mark Twain"],
                correctAnswerIndex: 1,
                explanation: "William Shakespeare wrote 'Romeo and Juliet' around 1594-1596, one of his most famous tragedies.",
                points: 10
            ),
            Question(
                text: "What is the first book in the Harry Potter series?",
                options: ["Chamber of Secrets", "Prisoner of Azkaban", "Philosopher's Stone", "Goblet of Fire"],
                correctAnswerIndex: 2,
                explanation: "'Harry Potter and the Philosopher's Stone' (or 'Sorcerer's Stone' in the US) is the first book in the series.",
                points: 10
            ),
            Question(
                text: "Who wrote '1984'?",
                options: ["Aldous Huxley", "Ray Bradbury", "George Orwell", "Arthur C. Clarke"],
                correctAnswerIndex: 2,
                explanation: "George Orwell wrote '1984', published in 1949, a dystopian novel about totalitarianism.",
                points: 10
            ),
            Question(
                text: "What epic poem did Homer write about the Trojan War?",
                options: ["The Odyssey", "The Iliad", "The Aeneid", "Beowulf"],
                correctAnswerIndex: 1,
                explanation: "The Iliad, attributed to Homer, is an ancient Greek epic poem set during the Trojan War.",
                points: 15
            ),
            Question(
                text: "Who wrote 'Pride and Prejudice'?",
                options: ["Emily Brontë", "Charlotte Brontë", "Jane Austen", "Mary Shelley"],
                correctAnswerIndex: 2,
                explanation: "Jane Austen wrote 'Pride and Prejudice', published in 1813, one of the most beloved romance novels.",
                points: 10
            )
        ]
        
        return Quiz(
            title: "Literary Legends",
            description: "Journey through the greatest works of literature and their authors",
            category: .literature,
            difficulty: .easy,
            questions: questions,
            icon: "text.book.closed",
            estimatedTime: 5
        )
    }
}

