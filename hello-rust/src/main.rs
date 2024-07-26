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

    let result = mul(10, 2);
    println!("Result: {result}");
}

/// Safely divide two numbers.
fn safediv(x: i32, y: i32) -> Result<i32, String> {
    if y == 0 {
        return Err(String::from("Division by zero!"));
    }
    Ok(x/y)
}


fn mul(x: i32, y: i32) -> i32 {
    x * y
}
