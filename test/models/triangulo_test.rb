require 'test_helper'

class TrianguloTest < ActiveSupport::TestCase
  def test_equilatero
    assert_equal 'Equilatero', Triangulo.validar(3, 3, 3)
    assert_equal 'Equilatero', Triangulo.validar(5, 5, 5)
  end

  def test_isosceles
    assert_equal 'Isosceles', Triangulo.validar(3, 3, 4)
    assert_equal 'Isosceles', Triangulo.validar(7, 12, 7)
  end

  def test_escaleno
    assert_equal 'Escaleno', Triangulo.validar(2, 3, 4)
    assert_equal 'Escaleno', Triangulo.validar(9, 12, 15)
  end

  def test_invalido
    assert_equal 'Invalido', Triangulo.validar(1, 2, 4)
    assert_equal 'Invalido', Triangulo.validar(1, -2, 4)
  end
end
