# Chapter 6: The Implementer Agent

The Implementer agent is your expert code craftsman, specializing in writing clean, maintainable, and production-ready code. This chapter explores how to effectively use the Implementer agent for high-quality software development.

## Role and Responsibilities

### Primary Focus Areas

The Implementer agent excels at:

- **Code Development**: Writing clean, efficient, and maintainable code
- **Best Practices**: Following industry coding standards and patterns
- **Problem Solving**: Translating requirements into working solutions
- **Code Organization**: Structuring code for readability and maintainability
- **Performance Optimization**: Writing efficient and performant code
- **Testing Integration**: Creating code that's easily testable

### Core Responsibilities

1. **Requirement Analysis**: Understanding functional and non-functional requirements
2. **Code Implementation**: Writing production-quality code
3. **Design Patterns**: Applying appropriate design patterns
4. **Error Handling**: Implementing robust error handling
5. **Documentation**: Writing clear code comments and documentation
6. **Integration**: Ensuring code integrates well with existing systems

## When to Use the Implementer Agent

### Ideal Scenarios

Use the Implementer agent when:

#### **Feature Implementation**
```
Scenario: Adding new functionality to an application
Input: "Implement user authentication with JWT tokens, including login, logout, and token refresh"
Output: Complete authentication module with proper error handling and security measures
```

#### **API Development**
```
Scenario: Creating REST API endpoints
Input: "Create REST API for user management with CRUD operations, validation, and error responses"
Output: Complete API controller with middleware, validation, and proper HTTP status codes
```

#### **Component Development**
```
Scenario: Building reusable UI components
Input: "Create a reusable data table component with sorting, filtering, and pagination for React"
Output: Fully functional React component with TypeScript types and comprehensive props
```

#### **Algorithm Implementation**
```
Scenario: Implementing complex business logic
Input: "Implement a recommendation algorithm based on user behavior and collaborative filtering"
Output: Optimized algorithm with proper data structures and edge case handling
```

### Not Ideal For

- **System Architecture**: Use the Architect agent for high-level design
- **Testing Strategy**: Use the Tester agent for comprehensive test planning
- **Code Review**: Use the Reviewer agent for quality assessment
- **Bug Investigation**: Use the Debugger agent for troubleshooting

## Implementer Agent Capabilities

### Programming Languages Expertise

The Implementer agent has deep knowledge of:

#### **Web Development**
- **JavaScript/TypeScript**: Node.js, Express, React, Vue, Angular
- **Python**: Django, Flask, FastAPI, pandas, NumPy
- **Go**: Gin, Echo, standard library, concurrency patterns
- **Java**: Spring Boot, Jakarta EE, Maven/Gradle
- **PHP**: Laravel, Symfony, Composer

#### **Mobile Development**
- **React Native**: Cross-platform mobile apps
- **Flutter**: Dart-based mobile development
- **Swift**: iOS native development
- **Kotlin**: Android native development

#### **Systems Programming**
- **Rust**: Systems programming with memory safety
- **C++**: High-performance systems development
- **C**: Low-level system programming

#### **Data Science**
- **Python**: pandas, NumPy, scikit-learn, TensorFlow
- **R**: Statistical analysis and visualization
- **SQL**: Database queries and optimization

### Framework and Library Expertise

#### **Frontend Frameworks**
- React, Vue.js, Angular, Svelte
- Next.js, Nuxt.js, Gatsby
- Material-UI, Ant Design, Bootstrap
- Redux, MobX, Zustand

#### **Backend Frameworks**
- Express.js, FastAPI, Django, Flask
- Spring Boot, ASP.NET Core
- Gin, Echo (Go)
- Laravel, Symfony (PHP)

#### **Database Technologies**
- PostgreSQL, MySQL, MongoDB
- Redis, Cassandra, DynamoDB
- Prisma, SQLAlchemy, TypeORM
- GraphQL, REST APIs

### Development Patterns and Practices

#### **Code Organization**
- Modular architecture
- Clean code principles
- SOLID principles
- Design patterns implementation
- Separation of concerns

#### **Error Handling**
- Graceful error handling
- Proper logging
- User-friendly error messages
- Recovery strategies
- Input validation

#### **Performance Optimization**
- Efficient algorithms
- Memory management
- Database query optimization
- Caching strategies
- Async/await patterns

## Using the Implementer Agent

### Basic Usage

#### **Command Line Interface**
```bash
# Basic feature implementation
opencode-setup agents execute implementer \
  --task "Implement user registration with email verification" \
  --language "javascript" \
  --framework "express"

# API endpoint creation
opencode-setup agents execute implementer \
  --task "Create REST API endpoints for product management" \
  --context "Node.js, Express, PostgreSQL, Prisma"

# Component development
opencode-setup agents execute implementer \
  --task "Create reusable modal component" \
  --language "typescript" \
  --framework "react" \
  --library "material-ui"
```

#### **Interactive Mode**
```bash
# Start interactive implementation session
opencode-setup agents execute implementer --interactive

# Example interaction:
> What would you like to implement?
I need to implement a file upload service

> What are the requirements?
- Support multiple file types
- Progress tracking
- File size limits
- Cloud storage integration

> Any specific technologies?
Node.js with Express and AWS S3
```

### Advanced Usage

#### **Specification-Driven Development**
```bash
# Create implementation specification
cat > feature-spec.json << EOF
{
  "feature": "user_authentication",
  "requirements": {
    "login": {
      "method": "POST",
      "endpoint": "/api/auth/login",
      "input": ["email", "password"],
      "output": ["token", "user", "expires_in"]
    },
    "register": {
      "method": "POST",
      "endpoint": "/api/auth/register",
      "input": ["email", "password", "name"],
      "output": ["user", "message"]
    },
    "refresh": {
      "method": "POST",
      "endpoint": "/api/auth/refresh",
      "input": ["refresh_token"],
      "output": ["token", "expires_in"]
    }
  },
  "security": {
    "password_hashing": "bcrypt",
    "jwt_secret": "env_variable",
    "token_expiry": "24h"
  },
  "validation": {
    "email": "required|email",
    "password": "required|min:8"
  }
}
EOF

# Implement from specification
opencode-setup agents execute implementer \
  --spec feature-spec.json \
  --output auth-module/
```

#### **Incremental Implementation**
```bash
# Phase 1: Basic structure
opencode-setup agents execute implementer \
  --task "Create basic user model and database schema" \
  --phase "structure" \
  --output models/user.js

# Phase 2: Core functionality
opencode-setup agents execute implementer \
  --task "Implement user CRUD operations" \
  --phase "core" \
  --input models/user.js \
  --output controllers/userController.js

# Phase 3: API endpoints
opencode-setup agents execute implementer \
  --task "Create API routes for user management" \
  --phase "api" \
  --input controllers/userController.js \
  --output routes/users.js
```

#### **Test-Driven Implementation**
```bash
# Generate tests first
opencode-setup agents execute tester \
  --task "Create tests for user authentication" \
  --output tests/auth.test.js

# Implement to pass tests
opencode-setup agents execute implementer \
  --task "Implement authentication to satisfy tests" \
  --test-driven true \
  --tests tests/auth.test.js \
  --output auth/
```

## Input and Output Examples

### Input Examples

#### **Simple Request**
```
Implement a REST API for managing blog posts with CRUD operations
```

#### **Detailed Request**
```
Implement a user management system with the following features:
- User registration with email verification
- Login with JWT authentication
- Password reset functionality
- Profile management with avatar upload
- Role-based access control (admin, user, moderator)

Technical requirements:
- Node.js with Express framework
- PostgreSQL database with Prisma ORM
- Input validation with Joi
- Error handling middleware
- Logging with Winston
- Unit tests with Jest

Security requirements:
- Password hashing with bcrypt
- Rate limiting on auth endpoints
- CORS configuration
- Input sanitization
```

#### **API Specification**
```
Create REST API endpoints for product management:

GET /api/products - List all products (paginated)
GET /api/products/:id - Get product by ID
POST /api/products - Create new product (admin only)
PUT /api/products/:id - Update product (admin only)
DELETE /api/products/:id - Delete product (admin only)

Product schema:
- id: UUID (primary key)
- name: string (required, max 255 chars)
- description: text (optional)
- price: decimal (required, min 0)
- category: string (required)
- stock: integer (required, min 0)
- created_at: timestamp
- updated_at: timestamp

Validation:
- Name and price are required
- Price must be positive
- Stock cannot be negative
- Category must be from predefined list
```

### Output Examples

#### **Complete API Implementation**
```javascript
// controllers/productController.js
const { Product } = require('../models');
const { validationResult } = require('express-validator');
const logger = require('../utils/logger');

class ProductController {
  // GET /api/products
  async getProducts(req, res) {
    try {
      const page = parseInt(req.query.page) || 1;
      const limit = parseInt(req.query.limit) || 10;
      const offset = (page - 1) * limit;

      const { count, rows: products } = await Product.findAndCountAll({
        limit,
        offset,
        order: [['created_at', 'DESC']]
      });

      res.json({
        products,
        pagination: {
          page,
          limit,
          total: count,
          pages: Math.ceil(count / limit)
        }
      });
    } catch (error) {
      logger.error('Error fetching products:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  // GET /api/products/:id
  async getProductById(req, res) {
    try {
      const product = await Product.findByPk(req.params.id);
      
      if (!product) {
        return res.status(404).json({ error: 'Product not found' });
      }

      res.json(product);
    } catch (error) {
      logger.error('Error fetching product:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  // POST /api/products
  async createProduct(req, res) {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ 
          error: 'Validation failed', 
          details: errors.array() 
        });
      }

      const product = await Product.create(req.body);
      
      logger.info(`Product created: ${product.id}`);
      res.status(201).json(product);
    } catch (error) {
      logger.error('Error creating product:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  // PUT /api/products/:id
  async updateProduct(req, res) {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ 
          error: 'Validation failed', 
          details: errors.array() 
        });
      }

      const product = await Product.findByPk(req.params.id);
      
      if (!product) {
        return res.status(404).json({ error: 'Product not found' });
      }

      await product.update(req.body);
      
      logger.info(`Product updated: ${product.id}`);
      res.json(product);
    } catch (error) {
      logger.error('Error updating product:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  // DELETE /api/products/:id
  async deleteProduct(req, res) {
    try {
      const product = await Product.findByPk(req.params.id);
      
      if (!product) {
        return res.status(404).json({ error: 'Product not found' });
      }

      await product.destroy();
      
      logger.info(`Product deleted: ${product.id}`);
      res.status(204).send();
    } catch (error) {
      logger.error('Error deleting product:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }
}

module.exports = new ProductController();
```

#### **React Component Implementation**
```tsx
// components/DataTable.tsx
import React, { useState, useEffect, useMemo } from 'react';
import {
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  TablePagination,
  TextField,
  InputAdornment,
  IconButton
} from '@mui/material';
import { Search, ArrowUpward, ArrowDownward } from '@mui/icons-material';

interface Column<T> {
  id: keyof T;
  label: string;
  sortable?: boolean;
  filterable?: boolean;
  render?: (value: any, row: T) => React.ReactNode;
}

interface DataTableProps<T> {
  data: T[];
  columns: Column<T>[];
  rowsPerPage?: number;
  searchable?: boolean;
  className?: string;
}

function DataTable<T extends Record<string, any>>({
  data,
  columns,
  rowsPerPage = 10,
  searchable = true,
  className
}: DataTableProps<T>) {
  const [page, setPage] = useState(0);
  const [rowsPerPageState, setRowsPerPageState] = useState(rowsPerPage);
  const [searchTerm, setSearchTerm] = useState('');
  const [sortColumn, setSortColumn] = useState<keyof T | null>(null);
  const [sortDirection, setSortDirection] = useState<'asc' | 'desc'>('asc');

  // Filter and sort data
  const filteredAndSortedData = useMemo(() => {
    let filtered = data;

    // Apply search filter
    if (searchTerm && searchable) {
      filtered = data.filter(row =>
        columns.some(column => {
          const value = row[column.id];
          return value && 
                 value.toString().toLowerCase().includes(searchTerm.toLowerCase());
        })
      );
    }

    // Apply sorting
    if (sortColumn) {
      filtered = [...filtered].sort((a, b) => {
        const aValue = a[sortColumn];
        const bValue = b[sortColumn];
        
        if (aValue === null || aValue === undefined) return 1;
        if (bValue === null || bValue === undefined) return -1;
        
        let comparison = 0;
        if (aValue > bValue) comparison = 1;
        if (aValue < bValue) comparison = -1;
        
        return sortDirection === 'desc' ? -comparison : comparison;
      });
    }

    return filtered;
  }, [data, searchTerm, sortColumn, sortDirection, columns, searchable]);

  // Paginate data
  const paginatedData = useMemo(() => {
    const startIndex = page * rowsPerPageState;
    return filteredAndSortedData.slice(startIndex, startIndex + rowsPerPageState);
  }, [filteredAndSortedData, page, rowsPerPageState]);

  const handleSort = (column: keyof T) => {
    if (sortColumn === column) {
      setSortDirection(sortDirection === 'asc' ? 'desc' : 'asc');
    } else {
      setSortColumn(column);
      setSortDirection('asc');
    }
  };

  const handleChangePage = (event: unknown, newPage: number) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event: React.ChangeEvent<HTMLInputElement>) => {
    setRowsPerPageState(parseInt(event.target.value, 10));
    setPage(0);
  };

  return (
    <Paper className={className}>
      {searchable && (
        <TextField
          fullWidth
          variant="outlined"
          placeholder="Search..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          InputProps={{
            startAdornment: (
              <InputAdornment position="start">
                <Search />
              </InputAdornment>
            ),
          }}
          sx={{ p: 2, pb: 1 }}
        />
      )}
      
      <TableContainer>
        <Table>
          <TableHead>
            <TableRow>
              {columns.map((column) => (
                <TableCell key={column.id.toString()}>
                  {column.sortable ? (
                    <IconButton
                      size="small"
                      onClick={() => handleSort(column.id)}
                      sx={{ fontWeight: 'bold' }}
                    >
                      {column.label}
                      {sortColumn === column.id && (
                        sortDirection === 'asc' ? <ArrowUpward /> : <ArrowDownward />
                      )}
                    </IconButton>
                  ) : (
                    column.label
                  )}
                </TableCell>
              ))}
            </TableRow>
          </TableHead>
          <TableBody>
            {paginatedData.map((row, index) => (
              <TableRow key={index}>
                {columns.map((column) => (
                  <TableCell key={column.id.toString()}>
                    {column.render 
                      ? column.render(row[column.id], row)
                      : row[column.id]
                    }
                  </TableCell>
                ))}
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
      
      <TablePagination
        rowsPerPageOptions={[5, 10, 25, 50]}
        component="div"
        count={filteredAndSortedData.length}
        rowsPerPage={rowsPerPageState}
        page={page}
        onPageChange={handleChangePage}
        onRowsPerPageChange={handleChangeRowsPerPage}
      />
    </Paper>
  );
}

export default DataTable;
```

## Best Practices for Implementer Agent

### Providing Good Input

#### **✅ Good Input Examples**
```
Implement a REST API for user management with:
- CRUD operations for users
- JWT authentication
- Input validation with Joi
- Error handling middleware
- PostgreSQL database with Prisma ORM
- Unit tests with Jest
```

#### **❌ Poor Input Examples**
```
Make a user API
```

### Structuring Requirements

Use the following structure for best results:

```markdown
## Feature Description
[Clear description of what needs to be implemented]

## Functional Requirements
[List of specific features and capabilities]

## Technical Requirements
[Programming language, frameworks, libraries]

## Non-Functional Requirements
[Performance, security, scalability requirements]

## Integration Requirements
[How it should integrate with existing code]

## Testing Requirements
[What tests should be included]
```

### Reviewing Implementation Output

When reviewing the Implementer agent's output:

1. **Functionality**: Does it meet all requirements?
2. **Code Quality**: Is the code clean and maintainable?
3. **Error Handling**: Are edge cases properly handled?
4. **Security**: Are security best practices followed?
5. **Performance**: Is the code efficient?
6. **Testing**: Are adequate tests included?

## Integration with Other Agents

### Typical Workflow Sequence

1. **Architect**: Design system architecture
2. **Implementer**: Implement based on architectural design
3. **Tester**: Create comprehensive tests
4. **Reviewer**: Review code quality and architecture compliance
5. **Documenter**: Create documentation

### Handoff Patterns

#### **Implementer → Tester**
The Implementer provides:
- Complete implementation code
- Usage examples
- Test requirements documentation
- Edge case documentation

#### **Implementer → Reviewer**
The Implementer provides:
- Source code with comments
- Implementation decisions documentation
- Trade-off analysis
- Performance considerations

## Common Use Cases

### **Use Case 1: API Development**

**Input**: "Create REST API for blog post management"

**Output**:
- Express.js controller with CRUD operations
- Input validation middleware
- Error handling
- Database integration
- API documentation

### **Use Case 2: Component Development**

**Input**: "Build reusable data table component for React"

**Output**:
- TypeScript React component
- Props interface definition
- Sorting and filtering functionality
- Pagination support
- Storybook stories

### **Use Case 3: Business Logic Implementation**

**Input**: "Implement order processing logic with payment integration"

**Output**:
- Order processing service
- Payment gateway integration
- Inventory management
- Notification system
- Error handling and recovery

## Troubleshooting

### Common Issues

#### **Issue: Incomplete Requirements**
**Problem**: Missing requirements lead to incomplete implementation
**Solution**: Provide detailed specifications and examples

#### **Issue: Technology Mismatch**
**Problem**: Implementation uses different technology than expected
**Solution**: Clearly specify technology stack and preferences

#### **Issue: Missing Error Handling**
**Problem**: Code lacks proper error handling
**Solution**: Specify error handling requirements and edge cases

#### **Issue: No Tests**
**Problem**: Implementation lacks test coverage
**Solution**: Request specific testing requirements

### Getting Better Results

1. **Be Specific**: Provide detailed requirements and constraints
2. **Include Examples**: Show expected input/output formats
3. **Specify Standards**: Define coding standards and patterns to follow
4. **Request Tests**: Always ask for appropriate test coverage
5. **Provide Context**: Include information about existing codebase

## Advanced Features

### **Code Generation from OpenAPI**
```bash
# Generate API client from OpenAPI spec
opencode-setup agents execute implementer \
  --task "Generate API client from OpenAPI specification" \
  --openapi-spec api.yaml \
  --language "typescript" \
  --output src/api/
```

### **Database Migration Generation**
```bash
# Generate database migrations
opencode-setup agents execute implementer \
  --task "Create database migrations for user schema changes" \
  --database "postgresql" \
  --orm "prisma" \
  --output prisma/migrations/
```

### **Performance Optimization**
```bash
# Optimize existing code
opencode-setup agents execute implementer \
  --task "Optimize slow database queries" \
  --input src/models/user.js \
  --profile true \
  --output optimized/
```

## Summary

The Implementer agent is your expert code craftsman for:

- **Feature Development**: Building complete, working features
- **Code Quality**: Writing clean, maintainable code
- **Best Practices**: Following industry standards and patterns
- **Integration**: Ensuring code works well with existing systems

By providing detailed requirements and technical specifications, you can leverage the Implementer agent to create high-quality, production-ready code that meets your exact needs.

The key to success with the Implementer agent is providing clear, comprehensive specifications and reviewing the output to ensure it meets all your requirements and quality standards.
