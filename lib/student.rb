require 'pry'

class Student
	attr_accessor :name, :grade
	attr_reader :id

	def self.create_table
		script = <<-SQL
		CREATE TABLE students (
			id INTEGER PRIMARY KEY,
			name TEXT,
			grade TEXT
		)
		SQL
		DB[:conn].execute(script)
	end

	def self.drop_table
		script = <<-SQL
		DROP TABLE students
		SQL

		DB[:conn].execute(script)
	end

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  def initialize(name, grade)
  	@name = name
  	@grade = grade
  end

  def save
  	script = <<-SQL
  		INSERT INTO students (name, grade)
  		VALUES (?, ?)
  	SQL

  	DB[:conn].execute(script,self.name,self.grade)

  	script = <<-SQL
  		SELECT *
  		FROM students
  		WHERE name = ?
  	SQL
  	@id = DB[:conn].execute(script,self.name)[0][0]

  end

  def self.create(name:, grade:)
  	student = self.new(name, grade)
  	student.save
  	student
  end
  
end
