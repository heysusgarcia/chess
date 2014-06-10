class Employee
  attr_reader :salary 
  
  def initialize(title, salary, boss)
    @title = title
    @salary = salary
    @boss = boss
  end
  
  def bonus(multiplier)
    bonus = @salary * multiplier
  end
  
  
end

class Manager < Employee
  def initialize(title, salary, boss, employees)
    super
    @employees = employees
  end
  
  def bonus(multiplier)
    total_employee_salary = 0
    @employees.each do |employee|
      if employee.is_a(Manager)
        total_employee_salary += (employee.bonus(multipler) / multiplier) + employee.salary
      else
        total_employee_salary += employee.salary
      end
      total_employee_salary * multiplier
  end
  
end