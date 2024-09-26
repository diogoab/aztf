import unittest
from math_service import MathService

class TestMathService(unittest.TestCase):
    def setUp(self):
        self.math_service = MathService()

    def test_add(self):
        result = self.math_service.add(2, 3)
        self.assertEqual(result, 5)

    def test_subtract(self):
        result = self.math_service.subtract(5, 3)
        self.assertEqual(result, 2)

    def test_multiply(self):
        result = self.math_service.multiply(4, 5)
        self.assertEqual(result, 20)

    def test_divide(self):
        result = self.math_service.divide(10, 2)
        self.assertEqual(result, 5)

    def test_divide_by_zero(self):
        with self.assertRaises(ValueError):
            self.math_service.divide(10, 0)

if __name__ == '__main__':
    unittest.main()