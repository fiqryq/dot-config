# TypeScript Guidelines and Best Practices

## Type System Fundamentals

### Type Annotations

```typescript
//  Good: Explicit and precise types
function calculateTotal(items: CartItem[]): number {
  return items.reduce((sum, item) => sum + item.price, 0);
}

// L Bad: Using 'any' defeats TypeScript's purpose
function processData(data: any): any {
  return data.something;
}
```

### Type Inference

```typescript
//  Good: Let TypeScript infer when obvious
const userName = "John"; // inferred as string
const count = 42; // inferred as number

//  Good: Explicit when not obvious
const users: User[] = []; // explicit for empty array
const response: ApiResponse<User> = await fetchUser(); // explicit for complex types

// L Bad: Redundant annotations
const name: string = "John"; // unnecessary, inference works
```

## Interface vs Type

### When to Use Interface

```typescript
//  Use interfaces for object shapes, especially when extending
interface User {
  id: string;
  name: string;
  email: string;
}

interface Admin extends User {
  permissions: string[];
}

//  Interfaces can be merged (declaration merging)
interface Window {
  customProperty: string;
}
```

### When to Use Type

```typescript
//  Use types for unions, intersections, and computed types
type Status = "pending" | "active" | "inactive";
type ID = string | number;

//  Use types for complex type manipulations
type ReadOnly<T> = {
  readonly [P in keyof T]: T[P];
};

type Nullable<T> = T | null;

//  Use types for tuples
type Coordinate = [number, number];
```

## Strict Type Checking

### Enable Strict Mode

```json
// tsconfig.json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true
  }
}
```

### Null Safety

```typescript
//  Good: Handle null/undefined explicitly
function getUser(id: string): User | null {
  const user = database.findUser(id);
  return user ?? null;
}

function displayUserName(user: User | null) {
  // Type guard
  if (!user) {
    return "Guest";
  }
  return user.name; // TypeScript knows user is not null
}

//  Good: Optional chaining and nullish coalescing
const userName = user?.profile?.name ?? "Anonymous";

// L Bad: Non-null assertion (use sparingly)
const name = user!.name; // dangerous if user could be null
```

## Advanced Types

### Union Types

```typescript
//  Good: Precise unions with discriminated unions
type Success<T> = {
  status: "success";
  data: T;
};

type Error = {
  status: "error";
  error: string;
};

type Result<T> = Success<T> | Error;

function handleResult(result: Result<User>) {
  if (result.status === "success") {
    console.log(result.data); // TypeScript knows this is Success
  } else {
    console.log(result.error); // TypeScript knows this is Error
  }
}
```

### Intersection Types

```typescript
//  Good: Combine multiple types
type Timestamped = {
  createdAt: Date;
  updatedAt: Date;
};

type Entity = {
  id: string;
};

type User = Entity &
  Timestamped & {
    name: string;
    email: string;
  };
```

### Generics

```typescript
//  Good: Reusable, type-safe functions
function first<T>(arr: T[]): T | undefined {
  return arr[0];
}

const firstNumber = first([1, 2, 3]); // number | undefined
const firstString = first(["a", "b"]); // string | undefined

//  Good: Generic constraints
function getProperty<T, K extends keyof T>(obj: T, key: K): T[K] {
  return obj[key];
}

const user = { name: "John", age: 30 };
const name = getProperty(user, "name"); // string
const age = getProperty(user, "age"); // number
// const invalid = getProperty(user, 'invalid'); // Error!

//  Good: Generic interfaces
interface ApiResponse<T> {
  data: T;
  status: number;
  message: string;
}

const userResponse: ApiResponse<User> = {
  data: { id: "1", name: "John", email: "john@example.com" },
  status: 200,
  message: "Success",
};
```

## Utility Types

### Built-in Utility Types

```typescript
// Partial - Make all properties optional
type PartialUser = Partial<User>;

// Required - Make all properties required
type RequiredUser = Required<PartialUser>;

// Pick - Select specific properties
type UserPreview = Pick<User, "id" | "name">;

// Omit - Exclude specific properties
type UserWithoutEmail = Omit<User, "email">;

// Record - Create object type with specific keys and values
type UserRoles = Record<string, User[]>;

// ReturnType - Extract return type from function
function getUser() {
  return { id: "1", name: "John" };
}
type User = ReturnType<typeof getUser>;

// Parameters - Extract parameter types
type GetUserParams = Parameters<typeof getUser>;

// Awaited - Unwrap Promise type
type UserData = Awaited<Promise<User>>;
```

### Custom Utility Types

```typescript
//  Make specific fields optional
type PartialBy<T, K extends keyof T> = Omit<T, K> & Partial<Pick<T, K>>;

type UserWithOptionalEmail = PartialBy<User, "email">;

//  Make fields nullable
type Nullable<T> = {
  [P in keyof T]: T[P] | null;
};

//  Deep readonly
type DeepReadonly<T> = {
  readonly [P in keyof T]: T[P] extends object ? DeepReadonly<T[P]> : T[P];
};
```

## Type Guards

### Built-in Type Guards

```typescript
// typeof
function processValue(value: string | number) {
  if (typeof value === "string") {
    return value.toUpperCase();
  }
  return value.toFixed(2);
}

// instanceof
class Dog {
  bark() {
    console.log("Woof!");
  }
}

function handlePet(pet: Dog | Cat) {
  if (pet instanceof Dog) {
    pet.bark();
  }
}

// in operator
function processShape(shape: Circle | Square) {
  if ("radius" in shape) {
    return Math.PI * shape.radius ** 2;
  }
  return shape.width ** 2;
}
```

### Custom Type Guards

```typescript
//  Good: User-defined type guard
interface Cat {
  meow(): void;
}

interface Dog {
  bark(): void;
}

function isCat(pet: Cat | Dog): pet is Cat {
  return (pet as Cat).meow !== undefined;
}

function handlePet(pet: Cat | Dog) {
  if (isCat(pet)) {
    pet.meow(); // TypeScript knows pet is Cat
  } else {
    pet.bark(); // TypeScript knows pet is Dog
  }
}

//  Good: Assertion function
function assertIsUser(value: unknown): asserts value is User {
  if (!value || typeof value !== "object") {
    throw new Error("Not a user");
  }
  if (!("id" in value) || !("name" in value)) {
    throw new Error("Not a user");
  }
}

function processUser(value: unknown) {
  assertIsUser(value);
  console.log(value.name); // TypeScript knows value is User
}
```

## Enums and Literal Types

### Prefer Literal Types over Enums

```typescript
//  Good: String literal union (preferred)
type Status = "pending" | "approved" | "rejected";

const status: Status = "pending";

//  Good: Const object (alternative to enum)
const Status = {
  Pending: "pending",
  Approved: "approved",
  Rejected: "rejected",
} as const;

type Status = (typeof Status)[keyof typeof Status];

// ? Acceptable: Enum (when you need reverse mapping)
enum HttpStatus {
  OK = 200,
  BadRequest = 400,
  NotFound = 404,
  InternalServerError = 500,
}
```

## Function Types

### Function Declarations

```typescript
//  Good: Explicit parameter and return types
function add(a: number, b: number): number {
  return a + b;
}

//  Good: Function type
type MathOperation = (a: number, b: number) => number;

const multiply: MathOperation = (a, b) => a * b;

//  Good: Optional and default parameters
function greet(name: string, title?: string): string {
  return title ? `Hello, ${title} ${name}` : `Hello, ${name}`;
}

function createUser(name: string, role: string = "user"): User {
  return { id: generateId(), name, role };
}
```

### Async Functions

```typescript
//  Good: Proper async/await typing
async function fetchUser(id: string): Promise<User> {
  const response = await fetch(`/api/users/${id}`);
  if (!response.ok) {
    throw new Error("Failed to fetch user");
  }
  return response.json();
}

//  Good: Error handling
async function safelyFetchUser(id: string): Promise<User | null> {
  try {
    return await fetchUser(id);
  } catch (error) {
    console.error("Error fetching user:", error);
    return null;
  }
}
```

## Classes

### Class Structure

```typescript
//  Good: Well-typed class with access modifiers
class UserService {
  private readonly apiUrl: string;
  private cache: Map<string, User> = new Map();

  constructor(apiUrl: string) {
    this.apiUrl = apiUrl;
  }

  async getUser(id: string): Promise<User> {
    const cached = this.cache.get(id);
    if (cached) return cached;

    const user = await this.fetchUser(id);
    this.cache.set(id, user);
    return user;
  }

  private async fetchUser(id: string): Promise<User> {
    const response = await fetch(`${this.apiUrl}/users/${id}`);
    return response.json();
  }
}

//  Good: Abstract classes and interfaces
abstract class Animal {
  abstract makeSound(): void;

  move(): void {
    console.log("Moving...");
  }
}

class Dog extends Animal {
  makeSound(): void {
    console.log("Woof!");
  }
}
```

## Module and Import Best Practices

### Import/Export

```typescript
//  Good: Named exports (preferred for tree-shaking)
export interface User {
  id: string;
  name: string;
}

export function getUser(id: string): User {
  // ...
}

//  Good: Type-only imports (faster compilation)
import type { User, UserRole } from "./types";
import { getUser } from "./api";

//  Good: Barrel exports (index.ts)
export { User, Admin } from "./user";
export { getUser, updateUser } from "./api";
export type { UserRole, Permission } from "./types";
```

## Error Handling

### Type-Safe Errors

```typescript
//  Good: Custom error classes
class ValidationError extends Error {
  constructor(
    message: string,
    public field: string,
    public value: unknown,
  ) {
    super(message);
    this.name = "ValidationError";
  }
}

//  Good: Result type pattern
type Result<T, E = Error> = { ok: true; value: T } | { ok: false; error: E };

function parseUser(data: unknown): Result<User, ValidationError> {
  try {
    // validation logic
    return { ok: true, value: validatedUser };
  } catch (error) {
    return {
      ok: false,
      error: new ValidationError("Invalid user data", "user", data),
    };
  }
}

// Usage
const result = parseUser(rawData);
if (result.ok) {
  console.log(result.value);
} else {
  console.error(result.error.message);
}
```

## Best Practices Summary

### DO:

-  Enable strict mode in tsconfig.json
-  Use interfaces for object shapes
-  Use type aliases for unions and complex types
-  Leverage type inference when obvious
-  Use generics for reusable code
-  Write custom type guards for complex checks
-  Prefer `unknown` over `any` for truly unknown types
-  Use `const` assertions for literal types
-  Leverage utility types (Partial, Pick, Omit, etc.)
-  Document complex types with JSDoc comments

### DON'T:

- L Use `any` unless absolutely necessary
- L Disable type checking with `@ts-ignore` (use `@ts-expect-error` if needed)
- L Use non-null assertion (`!`) without good reason
- L Create overly complex type hierarchies
- L Ignore compiler errors
- L Use `as` for type coercion without validation
- L Export internal implementation types
- L Mutate readonly types
- L Use enums when literal types suffice
- L Write redundant type annotations

## Type Testing

```typescript
//  Good: Test your types
import { expectType } from "tsd";

type User = { id: string; name: string };

expectType<User>({ id: "1", name: "John" });
expectType<string>(user.id);

// Or use built-in type assertions
const _test: User = { id: "1", name: "John" }; // Compile-time check
```

## Performance Tips

1. **Use type-only imports** to speed up compilation
2. **Avoid complex type computations** in hot paths
3. **Use project references** for large codebases
4. **Enable incremental compilation** in tsconfig.json
5. **Limit the use of mapped types** in frequently used types
