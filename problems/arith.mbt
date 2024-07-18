fn is_odd(n : Int) -> Bool {
  n.land(1) == 1
}

test "odd number" {
  @test.is_true(is_odd(1))!
  @test.is_true(is_odd(3))!
  @test.is_true(is_odd(-1))!
  @test.is_true(is_odd(-3))!
  @test.is_false(is_odd(2))!
  @test.is_false(is_odd(4))!
  @test.is_false(is_odd(0))!
  @test.is_false(is_odd(-2))!
  @test.is_false(is_odd(-4))!
}

fn is_even(n : Int) -> Bool {
  n.land(1) == 0
}

test "even number" {
  @test.is_true(is_even(0))!
  @test.is_true(is_even(2))!
  @test.is_true(is_even(4))!
  @test.is_true(is_even(-2))!
  @test.is_true(is_even(-4))!
  @test.is_false(is_even(1))!
  @test.is_false(is_even(3))!
  @test.is_false(is_even(-1))!
  @test.is_false(is_even(-3))!
}


// See also: Miller–Rabin primality test
fn is_prime(n : Int) -> Bool {
  if n < 2 {
    return false
  }
  // assert n > 1
  for i = 2; i * i <= n; i = i + 1 {
    if n % i == 0 {
      return false
    }
  } else {
    return true
  }
}

test "determine whether a given integer number is prime" {
  @test.is_true(is_prime(2))!
  @test.is_true(is_prime(3))!
  @test.is_true(is_prime(5))!
  @test.is_true(is_prime(7))!
  @test.is_true(is_prime(11))!
  @test.is_true(is_prime(13))!
  @test.is_true(is_prime(17))!
  @test.is_true(is_prime(19))!
  @test.is_true(is_prime(23))!
  @test.is_true(is_prime(29))!
  @test.is_false(is_prime(1))!
  @test.is_false(is_prime(4))!
  @test.is_false(is_prime(6))!
  @test.is_false(is_prime(8))!
  @test.is_false(is_prime(9))!
}

fn gcd(a : Int, b : Int) -> Int {
  if b == 0 {
    a
  } else {
    gcd(b, a % b)
  }
}

test "compute greatest common divisor" {
  inspect(
    gcd(13, 27),
    content = "1"
  )!
  inspect(
    gcd(20536, 7826),
    content = "2"
  )!
}

fn coprime(a : Int, b : Int) -> Bool {
  gcd(a, b) == 1
}

test "determine whether two positive integer numbers are coprime" {
  @test.is_true(coprime(13, 27))!
  @test.is_false(coprime(20536, 7826))!
}

fn phi(n : Int) -> Int {
  if n == 1 {
    return 1
  }
  loop 1, 0 {
    d, acc => {
      if d < n {
        let acc = 
          if coprime(n, d) {
            acc + 1
          } else {
            acc
          }
        continue (d + 1), acc
      } else {
        acc
      }
    }
  }
}

fn factors(n : Int) -> Array[Int] {
  let res = Array::new(capacity = 42)
  fn go(d : Int, n : Int) -> Unit {
    if n != 1 {
      if n % d == 0 {
        res.push(d)
        go(d, n / d)
      } else {
        go(d + 1, n)
      }
    }
  }
  go(2, n)
  return res
}

test "prime factors" {
  inspect(
    factors(315),
    content = "[3, 3, 5, 7]"
  )!
}

fn goldbach(n : Int) -> (Int, Int) {
  loop 2 {
    d => { 
      if is_prime(d) && is_prime(n - d) {
        (d, n - d)
      } else {
        continue (d + 1)
      }
    }
  }
}

test "two prime numbers that sum up to a given even integer" {
  inspect(
    goldbach(28),
    content = "(5, 23)"
  )!
}