class Triangulo
  def self.validar(a, b, c)
    a, b, c = [a, b, c].sort

    if a + b <= c
      'Invalido'
    elsif a == c
      'Equilatero'
    elsif a == b || b == c
      'Isosceles'
    else
      'Escaleno'
    end
  end
end
