/**
 * Greets a user by name.
 * @param name - The name of the user to greet
 * @returns A greeting string with the current date
 */
export function greet(name) {
  const date = new Date().toLocaleDateString();
  return `Hello, ${name}! Welcome to the project. Today is ${date}.`;
}
