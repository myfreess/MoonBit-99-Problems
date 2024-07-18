fn last[T](arr : Array[T]) -> T? {
  if arr.length() == 0 {
    None
  } else {
    Some(arr[arr.length() - 1])
  }
}

fn last_two[T](arr : Array[T]) -> (T, T)? {
  if arr.length() < 2 {
    None
  } else {
    Some((arr[arr.length() - 2], arr[arr.length() - 1]))
  }
}

fn nth[T](arr : Array[T], n : Int) -> T? {
  if n < arr.length() {
    Some(arr[n])
  } else {
    None
  }
}




fn is_palindrome[T : Eq](arr : Array[T]) -> Bool {
  if arr.length() == 0 {
    return true
  }
  let midpoint = arr.length() / 2
  let last = arr.length() - 1
  for i = 0; i < midpoint; i = i + 1 {
    if arr[i] != arr[last - i] {
      return false
    }
  } else {
    return true
  }
}

test "palindrome" {
  @test.is_true(is_palindrome([]))!
  @test.is_true(is_palindrome(["x"]))!
  @test.is_true(is_palindrome(["a", "a"]))!
  @test.is_false(is_palindrome(["a", "b"]))!
  @test.is_true(is_palindrome(["y", "x", "y"]))!
}



fn compress[T : Eq](arr : Array[T]) -> Array[T] {
  let compressed = Array::new(capacity = arr.length())
  for i = 0; i < arr.length(); i = i + 1 {
    if not(compressed.contains(arr[i])) {
      compressed.push(arr[i])
    }
  } else {
    return compressed
  }
}

test "compress elements" {
  inspect(
    compress(["a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e"]),
    content = "[a, b, c, d, e]"
  )!
}

fn rle[T : Eq](arr : Array[T]) -> Array[(T, Int)] {
  let rlearr = Array::new(capacity = arr.length()) // set upperbound
  if arr.length() == 0 {
    return rlearr
  }
  let mut current = arr[0]
  let mut count = 1
  for i = 1; i < arr.length(); i = i + 1 {
    if arr[i] == current {
      count += 1
    } else {
      rlearr.push((current, count))
      current = arr[i]
      count = 1
    }
  } else {
    rlearr.push((current, count))
    return rlearr
  }
}

test "run-length encoding" {
  inspect(
    rle(["a"]),
    content = "[(a, 1)]"
  )!
  inspect(
    rle(["a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e"]),
    content = "[(a, 4), (b, 1), (c, 2), (a, 2), (d, 1), (e, 4)]"
  )!
  inspect(
    rle(["a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e"]),
    content = "[(a, 2), (b, 1), (c, 2), (a, 2), (d, 1), (e, 4)]"
  )!
}

fn rotate[T](arr : Array[T], n : Int) -> Array[T] {
  // n < arr.length()
  let rotated = Array::new(capacity = arr.length())
  for i = n; i < arr.length(); i = i + 1 {
    rotated.push(arr[i])
  }
  for i = 0; i < n; i = i + 1 {
    rotated.push(arr[i])
  } else {
    return rotated
  }
}

test "rotate an array" {
  inspect(
    rotate(["a", "b", "c", "d", "e", "f", "g", "h"], 3),
    content = "[d, e, f, g, h, a, b, c]"
  )!
  @test.eq(
    rotate(["a", "b", "c", "d", "e", "f", "g", "h"], 3),
    ["d", "e", "f", "g", "h", "a", "b", "c"]
  )!
}


fn next_permutation[T : Eq](arr : Array[T]) -> Array[T] {
  todo("next_permutation")
}