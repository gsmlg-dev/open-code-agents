# Chapter 7: The Tester Agent

The Tester agent is your quality assurance expert, specializing in creating comprehensive test suites that ensure software reliability and maintainability. This chapter explores how to leverage the Tester agent for robust testing strategies.

## Role and Responsibilities

### Primary Focus Areas

The Tester agent excels at:

- **Test Strategy**: Designing comprehensive testing approaches
- **Test Implementation**: Writing automated tests across all levels
- **Test Coverage**: Ensuring thorough coverage of functionality
- **Quality Assurance**: Establishing quality gates and standards
- **Performance Testing**: Creating performance and load tests
- **Test Automation**: Setting up automated testing pipelines

### Core Responsibilities

1. **Test Planning**: Designing test strategies and test plans
2. **Test Implementation**: Writing unit, integration, and end-to-end tests
3. **Test Data Management**: Creating and managing test data
4. **Test Environment Setup**: Configuring test environments
5. **Regression Testing**: Ensuring new changes don't break existing functionality
6. **Test Reporting**: Creating comprehensive test reports and metrics

## When to Use the Tester Agent

### Ideal Scenarios

Use the Tester agent when:

#### **New Feature Testing**
```
Scenario: Testing a new user authentication system
Input: "Create comprehensive tests for JWT authentication with login, logout, and token refresh"
Output: Complete test suite covering authentication flows, edge cases, and security scenarios
```

#### **API Testing**
```
Scenario: Testing REST API endpoints
Input: "Create integration tests for product management API with CRUD operations"
Output: API tests covering all endpoints, error cases, and data validation
```

#### **Component Testing**
```
Scenario: Testing React components
Input: "Create unit tests for reusable data table component with sorting and filtering"
Output: Component tests covering user interactions, props validation, and edge cases
```

#### **Performance Testing**
```
Scenario: Load testing critical endpoints
Input: "Create performance tests for user registration endpoint handling 1000 concurrent users"
Output: Load tests with performance benchmarks and bottleneck identification
```

### Not Ideal For

- **Code Implementation**: Use the Implementer agent for writing production code
- **Architecture Design**: Use the Architect agent for system design
- **Bug Fixing**: Use the Debugger agent for troubleshooting
- **Code Review**: Use the Reviewer agent for quality assessment

## Tester Agent Capabilities

### Testing Types Expertise

The Tester agent has deep knowledge of:

#### **Unit Testing**
- Test structure and organization
- Mock and stub creation
- Assertion libraries
- Test doubles and fakes
- Boundary value testing
- Equivalence partitioning

#### **Integration Testing**
- API testing
- Database integration
- External service integration
- Message queue testing
- Component integration
- Service orchestration

#### **End-to-End Testing**
- User journey testing
- Cross-browser testing
- Mobile app testing
- Workflow testing
- UI automation
- Visual regression testing

#### **Performance Testing**
- Load testing
- Stress testing
- Spike testing
- Volume testing
- Scalability testing
- Performance profiling

### Testing Frameworks and Tools

#### **JavaScript/TypeScript**
- **Jest**: Popular testing framework
- **Mocha**: Flexible testing framework
- **Vitest**: Fast unit test framework
- **Cypress**: End-to-end testing
- **Playwright**: Modern E2E testing
- **Testing Library**: Component testing utilities

#### **Python**
- **Pytest**: Powerful testing framework
- **Unittest**: Built-in testing framework
- **Robot Framework**: Acceptance testing
- **Locust**: Load testing
- **Selenium**: Web automation

#### **Java**
- **JUnit**: Standard testing framework
- **TestNG**: Advanced testing framework
- **Mockito**: Mocking framework
- **Rest-Assured**: API testing
- **Selenide**: Web automation

#### **Go**
- **Testing package**: Built-in testing
- **Testify**: Assertion toolkit
- **Ginkgo**: BDD testing framework
- **Gomega**: Matcher library

### Testing Strategies and Patterns

#### **Test Pyramid**
- Unit tests (70%)
- Integration tests (20%)
- End-to-end tests (10%)

#### **Testing Patterns**
- Arrange-Act-Assert pattern
- Given-When-Then pattern
- Page Object Model
- Data-Driven Testing
- Behavior-Driven Development

#### **Quality Gates**
- Code coverage thresholds
- Performance benchmarks
- Security scanning
- Accessibility testing
- Usability testing

## Using the Tester Agent

### Basic Usage

#### **Command Line Interface**
```bash
# Basic test creation
opencode-setup agents execute tester \
  --task "Create tests for user authentication service" \
  --type "unit,integration" \
  --framework "jest"

# API testing
opencode-setup agents execute tester \
  --task "Create integration tests for product API" \
  --type "integration" \
  --framework "supertest"

# Component testing
opencode-setup agents execute tester \
  --task "Create tests for React data table component" \
  --type "unit" \
  --framework "react-testing-library"
```

#### **Interactive Mode**
```bash
# Start interactive testing session
opencode-setup agents execute tester --interactive

# Example interaction:
> What would you like to test?
I need to test the user registration API

> What type of tests?
Unit tests for validation logic and integration tests for API endpoints

> Any specific requirements?
Cover success cases, validation errors, and edge cases
```

### Advanced Usage

#### **Comprehensive Test Suite Generation**
```bash
# Create test specification
cat > test-requirements.json << EOF
{
  "feature": "user_management",
  "components": [
    {
      "name": "userController",
      "type": "unit",
      "framework": "jest",
      "coverage_target": 90
    },
    {
      "name": "userAPI",
      "type": "integration",
      "framework": "supertest",
      "endpoints": [
        "POST /api/users/register",
        "POST /api/users/login",
        "GET /api/users/profile",
        "PUT /api/users/profile"
      ]
    },
    {
      "name": "userWorkflow",
      "type": "e2e",
      "framework": "cypress",
      "scenarios": [
        "user_registration_flow",
        "login_and_profile_update",
        "password_reset_flow"
      ]
    }
  ],
  "test_data": {
    "valid_users": 10,
    "invalid_emails": 5,
    "edge_cases": ["duplicate_email", "weak_password", "missing_fields"]
  },
  "performance": {
    "load_test": true,
    "concurrent_users": 100,
    "duration": "5m"
  }
}
EOF

# Generate comprehensive test suite
opencode-setup agents execute tester \
  --spec test-requirements.json \
  --output tests/
```

#### **Test-Driven Development Support**
```bash
# Generate failing tests first
opencode-setup agents execute tester \
  --task "Create TDD tests for shopping cart functionality" \
  --tdd true \
  --output tests/cart.test.js

# Implementation will be done by Implementer agent
opencode-setup agents execute implementer \
  --task "Implement shopping cart to satisfy tests" \
  --test-driven true \
  --tests tests/cart.test.js
```

#### **Regression Test Generation**
```bash
# Analyze code changes and generate regression tests
opencode-setup agents execute tester \
  --task "Generate regression tests for recent changes" \
  --changes "git diff HEAD~1 HEAD" \
  --focus "critical_paths" \
  --output tests/regression/
```

## Input and Output Examples

### Input Examples

#### **Simple Request**
```
Create unit tests for user authentication service
```

#### **Detailed Request**
```
Create comprehensive tests for e-commerce shopping cart system:

Unit Tests:
- Cart item addition/removal
- Price calculation with discounts
- Inventory validation
- Coupon code validation

Integration Tests:
- Cart API endpoints
- Payment integration
- Inventory service integration
- User session management

E2E Tests:
- Complete shopping flow
- Multi-item cart management
- Payment processing
- Order confirmation

Requirements:
- Jest for unit tests
- Supertest for API tests
- Cypress for E2E tests
- 90% code coverage target
- Performance testing for cart operations
```

#### **API Testing Specification**
```
Create integration tests for user management API:

Endpoints to test:
POST /api/users/register
- Valid registration
- Duplicate email
- Invalid email format
- Weak password rejection
- Missing required fields

POST /api/users/login
- Valid credentials
- Invalid email
- Invalid password
- Non-existent user
- Account locked

GET /api/users/profile
- Authenticated user
- Invalid token
- Expired token

PUT /api/users/profile
- Valid update
- Invalid data
- Unauthorized access

Requirements:
- Use Supertest framework
- Test database with fixtures
- Mock external services
- Response time assertions
- Status code validation
```

### Output Examples

#### **Complete Unit Test Suite**
```javascript
// tests/services/userService.test.js
const userService = require('../../src/services/userService');
const { User } = require('../../src/models');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

// Mock dependencies
jest.mock('../../src/models');
jest.mock('bcrypt');
jest.mock('jsonwebtoken');

describe('UserService', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('registerUser', () => {
    const validUserData = {
      email: 'test@example.com',
      password: 'SecurePass123!',
      name: 'Test User'
    };

    it('should register a new user successfully', async () => {
      // Arrange
      const hashedPassword = 'hashedPassword';
      const createdUser = { id: 1, ...validUserData, password: hashedPassword };
      
      User.findOne.mockResolvedValue(null);
      bcrypt.hash.mockResolvedValue(hashedPassword);
      User.create.mockResolvedValue(createdUser);

      // Act
      const result = await userService.registerUser(validUserData);

      // Assert
      expect(User.findOne).toHaveBeenCalledWith({ 
        where: { email: validUserData.email } 
      });
      expect(bcrypt.hash).toHaveBeenCalledWith(validUserData.password, 10);
      expect(User.create).toHaveBeenCalledWith({
        ...validUserData,
        password: hashedPassword
      });
      expect(result).toEqual(createdUser);
    });

    it('should throw error if email already exists', async () => {
      // Arrange
      User.findOne.mockResolvedValue({ id: 1, email: validUserData.email });

      // Act & Assert
      await expect(userService.registerUser(validUserData))
        .rejects.toThrow('Email already exists');
    });

    it('should throw error for invalid email format', async () => {
      // Arrange
      const invalidUserData = { ...validUserData, email: 'invalid-email' };

      // Act & Assert
      await expect(userService.registerUser(invalidUserData))
        .rejects.toThrow('Invalid email format');
    });

    it('should throw error for weak password', async () => {
      // Arrange
      const weakPasswordData = { ...validUserData, password: '123' };

      // Act & Assert
      await expect(userService.registerUser(weakPasswordData))
        .rejects.toThrow('Password must be at least 8 characters long');
    });
  });

  describe('authenticateUser', () => {
    const validCredentials = {
      email: 'test@example.com',
      password: 'SecurePass123!'
    };

    it('should authenticate user with valid credentials', async () => {
      // Arrange
      const user = {
        id: 1,
        email: validCredentials.email,
        password: 'hashedPassword',
        name: 'Test User'
      };
      const token = 'jwt-token';

      User.findOne.mockResolvedValue(user);
      bcrypt.compare.mockResolvedValue(true);
      jwt.sign.mockReturnValue(token);

      // Act
      const result = await userService.authenticateUser(validCredentials);

      // Assert
      expect(User.findOne).toHaveBeenCalledWith({ 
        where: { email: validCredentials.email } 
      });
      expect(bcrypt.compare).toHaveBeenCalledWith(
        validCredentials.password, 
        user.password
      );
      expect(jwt.sign).toHaveBeenCalledWith(
        { userId: user.id, email: user.email },
        process.env.JWT_SECRET,
        { expiresIn: '24h' }
      );
      expect(result).toEqual({ user, token });
    });

    it('should throw error for non-existent user', async () => {
      // Arrange
      User.findOne.mockResolvedValue(null);

      // Act & Assert
      await expect(userService.authenticateUser(validCredentials))
        .rejects.toThrow('Invalid credentials');
    });

    it('should throw error for incorrect password', async () => {
      // Arrange
      const user = {
        id: 1,
        email: validCredentials.email,
        password: 'hashedPassword'
      };

      User.findOne.mockResolvedValue(user);
      bcrypt.compare.mockResolvedValue(false);

      // Act & Assert
      await expect(userService.authenticateUser(validCredentials))
        .rejects.toThrow('Invalid credentials');
    });
  });

  describe('getUserProfile', () => {
    const userId = 1;

    it('should return user profile for valid user ID', async () => {
      // Arrange
      const userProfile = {
        id: userId,
        email: 'test@example.com',
        name: 'Test User',
        createdAt: new Date()
      };

      User.findByPk.mockResolvedValue(userProfile);

      // Act
      const result = await userService.getUserProfile(userId);

      // Assert
      expect(User.findByPk).toHaveBeenCalledWith(userId, {
        attributes: { exclude: ['password'] }
      });
      expect(result).toEqual(userProfile);
    });

    it('should throw error for non-existent user', async () => {
      // Arrange
      User.findByPk.mockResolvedValue(null);

      // Act & Assert
      await expect(userService.getUserProfile(userId))
        .rejects.toThrow('User not found');
    });
  });
});
```

#### **API Integration Tests**
```javascript
// tests/integration/users.test.js
const request = require('supertest');
const app = require('../../src/app');
const { User } = require('../../src/models');
const { generateToken } = require('../../src/utils/auth');

describe('User API Integration Tests', () => {
  let testUser;
  let authToken;

  beforeAll(async () => {
    // Setup test database
    await User.sync({ force: true });
    
    // Create test user
    testUser = await User.create({
      email: 'test@example.com',
      password: 'hashedPassword',
      name: 'Test User'
    });
    
    authToken = generateToken(testUser.id);
  });

  afterAll(async () => {
    // Cleanup test database
    await User.drop();
  });

  describe('POST /api/users/register', () => {
    it('should register a new user', async () => {
      const newUser = {
        email: 'newuser@example.com',
        password: 'SecurePass123!',
        name: 'New User'
      };

      const response = await request(app)
        .post('/api/users/register')
        .send(newUser)
        .expect(201);

      expect(response.body).toHaveProperty('id');
      expect(response.body.email).toBe(newUser.email);
      expect(response.body.name).toBe(newUser.name);
      expect(response.body).not.toHaveProperty('password');
    });

    it('should return 400 for duplicate email', async () => {
      const duplicateUser = {
        email: testUser.email,
        password: 'SecurePass123!',
        name: 'Duplicate User'
      };

      const response = await request(app)
        .post('/api/users/register')
        .send(duplicateUser)
        .expect(400);

      expect(response.body.error).toBe('Email already exists');
    });

    it('should return 400 for invalid email format', async () => {
      const invalidUser = {
        email: 'invalid-email',
        password: 'SecurePass123!',
        name: 'Invalid User'
      };

      const response = await request(app)
        .post('/api/users/register')
        .send(invalidUser)
        .expect(400);

      expect(response.body.error).toBe('Invalid email format');
    });

    it('should return 400 for weak password', async () => {
      const weakPasswordUser = {
        email: 'weak@example.com',
        password: '123',
        name: 'Weak Password User'
      };

      const response = await request(app)
        .post('/api/users/register')
        .send(weakPasswordUser)
        .expect(400);

      expect(response.body.error).toBe('Password must be at least 8 characters long');
    });
  });

  describe('POST /api/users/login', () => {
    it('should login with valid credentials', async () => {
      const credentials = {
        email: testUser.email,
        password: 'SecurePass123!'
      };

      const response = await request(app)
        .post('/api/users/login')
        .send(credentials)
        .expect(200);

      expect(response.body).toHaveProperty('token');
      expect(response.body.user.email).toBe(testUser.email);
      expect(response.body.user).not.toHaveProperty('password');
    });

    it('should return 401 for invalid email', async () => {
      const credentials = {
        email: 'nonexistent@example.com',
        password: 'SecurePass123!'
      };

      const response = await request(app)
        .post('/api/users/login')
        .send(credentials)
        .expect(401);

      expect(response.body.error).toBe('Invalid credentials');
    });

    it('should return 401 for invalid password', async () => {
      const credentials = {
        email: testUser.email,
        password: 'wrongpassword'
      };

      const response = await request(app)
        .post('/api/users/login')
        .send(credentials)
        .expect(401);

      expect(response.body.error).toBe('Invalid credentials');
    });
  });

  describe('GET /api/users/profile', () => {
    it('should return user profile with valid token', async () => {
      const response = await request(app)
        .get('/api/users/profile')
        .set('Authorization', `Bearer ${authToken}`)
        .expect(200);

      expect(response.body.email).toBe(testUser.email);
      expect(response.body.name).toBe(testUser.name);
      expect(response.body).not.toHaveProperty('password');
    });

    it('should return 401 without token', async () => {
      const response = await request(app)
        .get('/api/users/profile')
        .expect(401);

      expect(response.body.error).toBe('Access token required');
    });

    it('should return 401 with invalid token', async () => {
      const response = await request(app)
        .get('/api/users/profile')
        .set('Authorization', 'Bearer invalid-token')
        .expect(401);

      expect(response.body.error).toBe('Invalid token');
    });
  });

  describe('PUT /api/users/profile', () => {
    it('should update user profile with valid data', async () => {
      const updateData = {
        name: 'Updated Name',
        email: 'updated@example.com'
      };

      const response = await request(app)
        .put('/api/users/profile')
        .set('Authorization', `Bearer ${authToken}`)
        .send(updateData)
        .expect(200);

      expect(response.body.name).toBe(updateData.name);
      expect(response.body.email).toBe(updateData.email);
    });

    it('should return 400 for invalid email format', async () => {
      const updateData = {
        email: 'invalid-email'
      };

      const response = await request(app)
        .put('/api/users/profile')
        .set('Authorization', `Bearer ${authToken}`)
        .send(updateData)
        .expect(400);

      expect(response.body.error).toBe('Invalid email format');
    });

    it('should return 401 without authentication', async () => {
      const updateData = {
        name: 'Updated Name'
      };

      const response = await request(app)
        .put('/api/users/profile')
        .send(updateData)
        .expect(401);

      expect(response.body.error).toBe('Access token required');
    });
  });
});
```

#### **E2E Test with Cypress**
```javascript
// cypress/e2e/user-journey.cy.js
describe('User Registration and Login Journey', () => {
  beforeEach(() => {
    // Visit the application
    cy.visit('/');
  });

  it('should complete full user registration and login flow', () => {
    const user = {
      name: 'John Doe',
      email: 'john.doe@example.com',
      password: 'SecurePass123!'
    };

    // Navigate to registration
    cy.get('[data-cy=register-button]').click();
    cy.url().should('include', '/register');

    // Fill registration form
    cy.get('[data-cy=name-input]').type(user.name);
    cy.get('[data-cy=email-input]').type(user.email);
    cy.get('[data-cy=password-input]').type(user.password);
    cy.get('[data-cy=confirm-password-input]').type(user.password);

    // Submit registration
    cy.get('[data-cy=register-submit]').click();

    // Verify successful registration
    cy.url().should('include', '/dashboard');
    cy.get('[data-cy=welcome-message]')
      .should('contain', `Welcome, ${user.name}`);

    // Logout
    cy.get('[data-cy=logout-button]').click();
    cy.url().should('include', '/login');

    // Login with new credentials
    cy.get('[data-cy=email-input]').type(user.email);
    cy.get('[data-cy=password-input]').type(user.password);
    cy.get('[data-cy=login-submit]').click();

    // Verify successful login
    cy.url().should('include', '/dashboard');
    cy.get('[data-cy=user-profile]').should('contain', user.name);
  });

  it('should handle registration validation errors', () => {
    // Try to submit empty form
    cy.get('[data-cy=register-button]').click();
    cy.get('[data-cy=register-submit]').click();

    // Verify validation errors
    cy.get('[data-cy=name-error]').should('be.visible');
    cy.get('[data-cy=email-error]').should('be.visible');
    cy.get('[data-cy=password-error]').should('be.visible');

    // Try invalid email
    cy.get('[data-cy=name-input]').type('Test User');
    cy.get('[data-cy=email-input]').type('invalid-email');
    cy.get('[data-cy=password-input]').type('password123');
    cy.get('[data-cy=confirm-password-input]').type('password123');

    cy.get('[data-cy=register-submit]').click();

    // Verify email validation error
    cy.get('[data-cy=email-error]')
      .should('contain', 'Invalid email format');
  });

  it('should handle login errors', () => {
    // Navigate to login
    cy.get('[data-cy=login-button]').click();
    cy.url().should('include', '/login');

    // Try login with invalid credentials
    cy.get('[data-cy=email-input]').type('nonexistent@example.com');
    cy.get('[data-cy=password-input]').type('wrongpassword');
    cy.get('[data-cy=login-submit]').click();

    // Verify error message
    cy.get('[data-cy=login-error]')
      .should('contain', 'Invalid credentials');
  });
});

describe('Shopping Cart Functionality', () => {
  beforeEach(() => {
    // Login before each test
    cy.visit('/login');
    cy.get('[data-cy=email-input]').type('test@example.com');
    cy.get('[data-cy=password-input]').type('password123');
    cy.get('[data-cy=login-submit]').click();
    cy.url().should('include', '/dashboard');
  });

  it('should add items to cart and complete checkout', () => {
    const products = [
      { name: 'Product 1', price: 29.99 },
      { name: 'Product 2', price: 49.99 }
    ];

    // Add products to cart
    products.forEach(product => {
      cy.visit('/products');
      cy.contains(product.name).click();
      cy.get('[data-cy=add-to-cart]').click();
      cy.get('[data-cy=cart-count]')
        .should('contain', products.indexOf(product) + 1);
    });

    // View cart
    cy.get('[data-cy=cart-button]').click();
    cy.url().should('include', '/cart');

    // Verify cart contents
    cy.get('[data-cy=cart-item]').should('have.length', 2);
    cy.get('[data-cy=cart-total]')
      .should('contain', (29.99 + 49.99).toFixed(2));

    // Proceed to checkout
    cy.get('[data-cy=checkout-button]').click();
    cy.url().should('include', '/checkout');

    // Fill checkout form
    cy.get('[data-cy=shipping-address]').type('123 Main St');
    cy.get('[data-cy=shipping-city]').type('Anytown');
    cy.get('[data-cy=shipping-zip]').type('12345');

    // Complete checkout
    cy.get('[data-cy=place-order]').click();

    // Verify order confirmation
    cy.url().should('include', '/order-confirmation');
    cy.get('[data-cy=order-success]')
      .should('contain', 'Order placed successfully');
  });
});
```

## Best Practices for Tester Agent

### Providing Good Input

#### **✅ Good Input Examples**
```
Create comprehensive tests for user authentication:
- Unit tests for validation logic
- Integration tests for API endpoints
- E2E tests for user flows
- Performance tests for login endpoint
- Target 90% code coverage
```

#### **❌ Poor Input Examples**
```
Test the user service
```

### Structuring Test Requirements

Use the following structure for best results:

```markdown
## Test Scope
[What needs to be tested]

## Test Types Required
[Unit, Integration, E2E, Performance, etc.]

## Test Requirements
[Specific test cases and scenarios]

## Framework Preferences
[Testing frameworks and tools]

## Coverage Requirements
[Code coverage targets and quality gates]

## Performance Requirements
[Performance benchmarks and load requirements]
```

### Reviewing Test Output

When reviewing the Tester agent's output:

1. **Coverage**: Does it test all important scenarios?
2. **Quality**: Are the tests well-structured and maintainable?
3. **Edge Cases**: Are edge cases properly covered?
4. **Performance**: Are performance requirements tested?
5. **Integration**: Do integration tests work properly?
6. **Data**: Is test data properly managed?

## Integration with Other Agents

### Typical Workflow Sequence

1. **Implementer**: Implement the feature/code
2. **Tester**: Create comprehensive tests
3. **Reviewer**: Review both code and tests
4. **Debugger**: Fix any failing tests
5. **Documenter**: Document testing approach

### Handoff Patterns

#### **Tester → Reviewer**
The Tester provides:
- Complete test suite
- Test coverage reports
- Performance benchmarks
- Quality metrics

#### **Tester → Debugger**
The Tester provides:
- Failing test cases
- Error logs and diagnostics
- Reproduction steps
- Expected vs actual behavior

## Common Use Cases

### **Use Case 1: API Testing**

**Input**: "Create comprehensive tests for REST API"

**Output**:
- Unit tests for business logic
- Integration tests for API endpoints
- Contract testing for API contracts
- Performance tests for critical endpoints

### **Use Case 2: Component Testing**

**Input**: "Test React component library"

**Output**:
- Component unit tests
- Accessibility tests
- Visual regression tests
- Interaction tests

### **Use Case 3: Performance Testing**

**Input**: "Load test e-commerce checkout flow"

**Output**:
- Load test scenarios
- Performance benchmarks
- Bottleneck analysis
- Scalability tests

## Troubleshooting

### Common Issues

#### **Issue: Insufficient Test Coverage**
**Problem**: Tests don't cover important scenarios
**Solution**: Specify detailed test cases and edge cases

#### **Issue: Flaky Tests**
**Problem**: Tests are unreliable and fail intermittently
**Solution**: Request proper test isolation and deterministic behavior

#### **Issue: Slow Tests**
**Problem**: Test suite takes too long to run
**Solution**: Request test optimization and parallelization

#### **Issue: Complex Test Setup**
**Problem**: Tests require complex setup and teardown
**Solution**: Request better test fixtures and utilities

### Getting Better Results

1. **Specify Test Types**: Clearly define what types of tests are needed
2. **Provide Examples**: Show expected test scenarios and edge cases
3. **Define Coverage**: Specify coverage targets and quality gates
4. **Include Performance**: Define performance requirements and benchmarks
5. **Request Automation**: Ask for CI/CD integration and automation

## Advanced Features

### **Test Coverage Analysis**
```bash
# Analyze test coverage gaps
opencode-setup agents execute tester \
  --task "Analyze test coverage gaps" \
  --source src/ \
  --tests tests/ \
  --target 90 \
  --output coverage-report.html
```

### **Performance Benchmarking**
```bash
# Create performance benchmarks
opencode-setup agents execute tester \
  --task "Create performance benchmarks for API endpoints" \
  --baseline "current_performance.json" \
  --threshold "response_time < 200ms" \
  --output benchmarks/
```

### **Test Data Generation**
```bash
# Generate realistic test data
opencode-setup agents execute tester \
  --task "Generate test data for user management" \
  --count 1000 \
  --realistic true \
  --output fixtures/users.json
```

## Summary

The Tester agent is your quality assurance expert for:

- **Comprehensive Testing**: Creating thorough test suites across all levels
- **Quality Assurance**: Establishing quality standards and gates
- **Test Automation**: Setting up automated testing pipelines
- **Performance Testing**: Ensuring system performance meets requirements

By providing detailed testing requirements and quality criteria, you can leverage the Tester agent to create robust, reliable test suites that ensure your software meets the highest quality standards.

The key to success with the Tester agent is providing clear testing requirements, specifying coverage targets, and defining quality gates that align with your project's quality standards.
