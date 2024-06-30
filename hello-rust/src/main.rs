fn main() {
    let message = "World!!!";
    println!("Hello, {message}");

    let name = b"Tim";
    println!("{:?}", name);

    let array: [i32; 3] = [1, 2, 3];
    println!("{:?}", array);

    let result = safediv(10, 0);
    match result {
        Ok(value) => println!("Result: {}", value),
        Err(message) => println!("Error: {}", message),
    }

    if let Ok(value) = safediv(10, 2) {
        println!("Result: {}", value);
    }
    else {
        println!("Error: Division by zero!");
    }
}

/// Safely divide two numbers.
///
/// Arguments
/// `x` - The dividend.
/// `y` - The divisor.
///
/// Returns
/// The result of the division if `y` is not zero.
/// Otherwise, an error message.
///
/// Example
/// ```
/// let result = safediv(10, 2);
/// assert_eq!(result, Ok(5));
/// ```
fn safediv(x: i32, y: i32) -> Result<i32, String> {
    if y == 0 {
        return Err(String::from("Division by zero!"));
    }
    Ok(x/y)
}
