Feature: I can execute Behat tests with current API Extension

  Scenario: I can execute Behat tests
    When I run "behat --tags=~@debug"
    Then it should pass with:
    """
    20 scenarios (20 passed)
    """

  Scenario: I can debug beer item schema
    When I run "behat features/beer.feature:87"
    Then it should pass with:
    """
    1 scenario (1 passed)
    """
    And the output should contain:
    """
    {
        "type": "object",
        "properties": {
            "@id": {
                "type": "string",
                "pattern": "^\/beers\/[\\w-]+$"
            },
            "@type": {
                "type": "string",
                "pattern": "^Beer$"
            },
            "id": {
                "type": [
                    "integer"
                ]
            },
            "company": {
                "type": "object",
                "properties": {
                    "@id": {
                        "type": "string",
                        "pattern": "^\/companies\/[\\w-]+$"
                    },
                    "@type": {
                        "type": "string",
                        "pattern": "^Company$"
                    },
                    "name": {
                        "type": [
                            "string"
                        ]
                    }
                },
                "required": [
                    "@id",
                    "@type",
                    "name"
                ]
            },
            "name": {
                "type": [
                    "string"
                ]
            },
            "volume": {
                "type": [
                    "number",
                    "null"
                ]
            },
            "active": {
                "type": "boolean"
            },
            "price": {
                "type": [
                    "number"
                ]
            },
            "weight": {
                "type": [
                    "integer"
                ]
            },
            "description": {
                "type": [
                    "string"
                ]
            },
            "createdAt": {
                "type": [
                    "string"
                ],
                "pattern": "^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\+00:00$"
            },
            "currencyCode": {
                "type": [
                    "string"
                ]
            },
            "images": {
                "type": "array",
                "items": {
                    "type": "object",
                    "properties": {
                        "@id": {
                            "type": "string",
                            "pattern": "^\/images\/[\\w-]+$"
                        },
                        "@type": {
                            "type": "string",
                            "pattern": "^Image$"
                        },
                        "name": {
                            "type": [
                                "string"
                            ]
                        }
                    },
                    "required": [
                        "@id",
                        "@type",
                        "name"
                    ]
                }
            },
            "nbImages": {
                "type": [
                    "number"
                ]
            },
            "@context": {
                "type": "string",
                "pattern": "^\/contexts\/Beer$"
            }
        },
        "required": [
            "@id",
            "@type",
            "id",
            "company",
            "name",
            "active",
            "price",
            "weight",
            "description",
            "createdAt",
            "currencyCode",
            "nbImages",
            "@context"
        ]
    }
    """

  Scenario: I can debug beer list schema
    When I run "behat features/beer.feature:91"
    Then it should pass with:
    """
    1 scenario (1 passed)
    """
    And the output should contain:
    """
    {
      "type": "object",
      "properties": {
        "@context": {
          "type": "string",
          "pattern": "^\/contexts\/beers$"
        },
        "@id": {
          "type": "string",
          "pattern": "^\/beers$"
        },
        "@type": {
          "type": "string",
          "pattern": "^hydra:Collection$"
        },
        "hydra:member": {
          "type": "array",
          "items": {
            "type": "object",
            "properties": {
              "@id": {
                "type": "string",
                "pattern": "^\/beers\/[\\w-]+$"
              },
              "@type": {
                "type": "string",
                "pattern": "^Beer$"
              },
              "id": {
                "type": ["integer"]
              },
              "name": {
                "type": ["string"]
              }
            },
            "required": ["@id", "@type", "id", "name"]
          }
        }
      },
      "required": ["@context", "@id", "@type", "hydra:member"]
    }
    """

  Scenario: I can debug beer last request
    When I run "behat features/beer.feature:95"
    Then it should pass with:
    """
    1 scenario (1 passed)
    """
    And the output should contain:
    """
    {
      "company": "/companies/1",
      "name": "Foo",
      "volume": 6.3,
      "active": true,
      "price": 10.3,
      "weight": 3,
      "description": "Lorem ipsum dolor sit amet",
      "createdAt": "2018-04-08T22:03:17+00:00",
      "currencyCode": "EUR",
      "images": ["/images/1", "/images/2", "/images/3"]
    }
    """

  Scenario: I can debug company item schema
    When I run "behat features/company.feature:18"
    Then it should pass with:
    """
    1 scenario (1 passed)
    """
    And the output should contain:
    """
    {
      "type": "object",
      "properties": {
        "@context": {
          "type": "string",
          "pattern": "^\/contexts\/companies$"
        },
        "@id": {
          "type": "string",
          "pattern": "^\/companies\/[\\w-]+$"
        },
        "@type": {
          "type": "string",
          "pattern": "^Company$"
        },
        "name": {
          "type": ["string"]
        }
      },
      "required": ["@context", "@id", "@type", "name"]
    }
    """

  Scenario: I can debug company list schema
    When I run "behat features/company.feature:22"
    Then it should pass with:
    """
    1 scenario (1 passed)
    """
    And the output should contain:
    """
    {
      "type": "object",
      "properties": {
        "@context": {
          "type": "string",
          "pattern": "^\/contexts\/companies$"
        },
        "@id": {
          "type": "string",
          "pattern": "^\/companies$"
        },
        "@type": {
          "type": "string",
          "pattern": "^hydra:Collection$"
        },
        "hydra:member": {
          "type": "array",
          "items": {
            "type": "object",
            "properties": {
              "@id": {
                "type": "string",
                "pattern": "^\/companies\/[\\w-]+$"
              },
              "@type": {
                "type": "string",
                "pattern": "^Company$"
              },
              "name": {
                "type": ["string"]
              }
            },
            "required": ["@id", "@type", "name"]
          }
        },
        "hydra:totalItems": {
          "type": "int"
        }
      },
      "required": ["@context", "@id", "@type", "hydra:member", "hydra:totalItems"]
    }
    """

  Scenario: I can debug company last request
    When I run "behat features/company.feature:26"
    Then the output should contain:
    """
    Unknown operation post on ApiResource ApiExtension\App\Entity\Company.
    """