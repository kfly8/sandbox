Compare GraphQL::Language::Parser with Parser::GraphQL::XS

## Benchmark

```shell
% perl bench.pl
                             Rate GraphQL::Language::Parser  Parser::GraphQL::XS
GraphQL::Language::Parser  4745/s                        --                 -93%
Parser::GraphQL::XS       65761/s                     1286%                   --
```

## Parsed result

```perl
# XS RESULT
$VAR1 = {
          'definitions' => [
                             {
                               'name' => {
                                           'value' => 'Query',
                                           'kind' => 'Name',
                                           'loc' => {
                                                      'start' => {
                                                                   'column' => 6,
                                                                   'line' => 1
                                                                 },
                                                      'end' => {
                                                                 'line' => 1,
                                                                 'column' => 11
                                                               }
                                                    }
                                         },
                               'loc' => {
                                          'end' => {
                                                     'line' => 1,
                                                     'column' => 29
                                                   },
                                          'start' => {
                                                       'column' => 1,
                                                       'line' => 1
                                                     }
                                        },
                               'fields' => [
                                             {
                                               'directives' => undef,
                                               'name' => {
                                                           'kind' => 'Name',
                                                           'value' => 'hello',
                                                           'loc' => {
                                                                      'end' => {
                                                                                 'column' => 19,
                                                                                 'line' => 1
                                                                               },
                                                                      'start' => {
                                                                                   'column' => 14,
                                                                                   'line' => 1
                                                                                 }
                                                                    }
                                                         },
                                               'loc' => {
                                                          'start' => {
                                                                       'line' => 1,
                                                                       'column' => 14
                                                                     },
                                                          'end' => {
                                                                     'line' => 1,
                                                                     'column' => 27
                                                                   }
                                                        },
                                               'type' => {
                                                           'kind' => 'NamedType',
                                                           'loc' => {
                                                                      'start' => {
                                                                                   'column' => 21,
                                                                                   'line' => 1
                                                                                 },
                                                                      'end' => {
                                                                                 'line' => 1,
                                                                                 'column' => 27
                                                                               }
                                                                    },
                                                           'name' => {
                                                                       'loc' => {
                                                                                  'start' => {
                                                                                               'line' => 1,
                                                                                               'column' => 21
                                                                                             },
                                                                                  'end' => {
                                                                                             'column' => 27,
                                                                                             'line' => 1
                                                                                           }
                                                                                },
                                                                       'kind' => 'Name',
                                                                       'value' => 'String'
                                                                     }
                                                         },
                                               'kind' => 'FieldDefinition',
                                               'arguments' => undef
                                             }
                                           ],
                               'directives' => undef,
                               'kind' => 'ObjectTypeDefinition',
                               'interfaces' => undef
                             }
                           ],
          'loc' => {
                     'end' => {
                                'line' => 1,
                                'column' => 29
                              },
                     'start' => {
                                  'column' => 1,
                                  'line' => 1
                                }
                   },
          'kind' => 'Document'
        };


# PP RESULT
$VAR1 = [
          {
            'fields' => {
                          'hello' => {
                                       'type' => 'String'
                                     }
                        },
            'name' => 'Query',
            'location' => {
                            'column' => 29,
                            'line' => 1
                          },
            'kind' => 'type'
          }
        ];
```

```shell
❯ bun run parse.ts
{
  kind: "Document",
  definitions: [
    {
      kind: "ObjectTypeDefinition",
      description: undefined,
      name: [Object ...],
      interfaces: [],
      directives: [],
      fields: [
        [Object ...]
      ],
      loc: [Location ...],
    }
  ],
  loc: Location {
    start: 0,
    end: 28,
    startToken: Token {
      kind: "<SOF>",
      start: 0,
      end: 0,
      line: 0,
      column: 0,
      value: undefined,
      prev: null,
      next: [Token ...],
      toJSON: [Function: toJSON],
    },
    endToken: Token {
      kind: "<EOF>",
      start: 28,
      end: 28,
      line: 1,
      column: 29,
      value: undefined,
      prev: [Token ...],
      next: null,
      toJSON: [Function: toJSON],
    },
    source: Source {
      body: "type Query { hello: String }",
      name: "GraphQL request",
      locationOffset: [Object ...],
    },
    toJSON: [Function: toJSON],
  },
}
```

#          'loc' => {
#                     'start' => 0,
#                     'end' => 28
#                   },
#          'kind' => 'Document',
#          'definitions' => [
#                             {
#                               'directives' => [],
#                               'fields' => [
#                                             {
#                                               'loc' => {
#                                                          'end' => 26,
#                                                          'start' => 13
#                                                        },
#                                               'kind' => 'FieldDefinition',
#                                               'arguments' => [],
#                                               'type' => {
#                                                           'kind' => 'NamedType',
#                                                           'name' => {
#                                                                       'loc' => {
#                                                                                  'end' => 26,
#                                                                                  'start' => 20
#                                                                                },
#                                                                       'kind' => 'Name',
#                                                                       'value' => 'String'
#                                                                     },
#                                                           'loc' => {
#                                                                      'end' => 26,
#                                                                      'start' => 20
#                                                                    }
#                                                         },
#                                               'directives' => [],
#                                               'name' => {
#                                                           'loc' => {
#                                                                      'end' => 18,
#                                                                      'start' => 13
#                                                                    },
#                                                           'kind' => 'Name',
#                                                           'value' => 'hello'
#                                                         }
#                                             }
#                                           ],
#                               'name' => {
#                                           'loc' => {
#                                                      'start' => 5,
#                                                      'end' => 10
#                                                    },
#                                           'value' => 'Query',
#                                           'kind' => 'Name'
#                                         },
#                               'kind' => 'ObjectTypeDefinition',
#                               'interfaces' => [],
#                               'loc' => {
#                                          'end' => 28,
#                                          'start' => 0
#                                        }
#                             }
#                           ]
#        };
