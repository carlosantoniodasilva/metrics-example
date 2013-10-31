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

  def self.validar2(a, b, c)
    if (a + b < c) || (a + c < b) || (b + c < a)
      'Invalido'
    elsif (a == b) && (b == c)
      'Equilatero'
    elsif (a == b) || (b == c) || (a == c)
      'Isosceles'
    else
      'Escaleno'
    end
  end
end
