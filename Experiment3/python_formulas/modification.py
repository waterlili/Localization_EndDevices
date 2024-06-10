from decimal import Decimal

# Input: Two decimal numbers
number_a = Decimal(input("Enter number A: "))
number_b = Decimal(input("Enter number B: "))

# Calculate the difference
result = number_a - number_b

# Print the result with high precision
print(f"The difference is: {result}")

