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


