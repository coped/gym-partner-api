# Create mock user data in database
user = User.create!(
    name: "First User",
    email: "first@user.com",
    password: "foobar",
    password_confirmation: "foobar"
)

5.times do 
    User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: "foobar",
        password_confirmation: "foobar"
    )
end

# Parse exercise data from lib/exercises
exercises = ExerciseData.new

# Seed exercise data to database
exercises.seed

# Create a mock workout for manual testing purposes
user.workouts.create!(
    date: DateTime.now,
    exercises: [
        Exercise.first,
        Exercise.last
    ]
)