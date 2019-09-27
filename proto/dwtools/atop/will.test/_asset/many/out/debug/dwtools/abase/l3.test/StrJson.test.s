( function _StrJson_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wAppBasic' );
  _.include( 'wCopyable' );
  _.include( 'wStringer' );
  _.include( 'wTesting' );


}
var _global = _global_;
var _ = _global_.wTools;

//

var complexData =
{
  "string" : [
    "string",
    "string",
    "string",
    "string"
  ],
  "string" : {
    "string" : {
      "string" : "string",
      "string" : 288,
      "string" : "string",
      "string" : false,
      "string" : true,
      "string" : false,
      "string" : false
    },
    "string" : {
      "string" : "string",
      "string" : 3,
      "string" : "string",
      "string" : false,
      "string" : false,
      "string" : false,
      "string" : false
    },
    "string" : {
      "string" : "string",
      "string" : 36,
      "string" : "string",
      "string" : true,
      "string" : false,
      "string" : false,
      "string" : false,
      "string" : [
        1,
        1
      ],
      "string" : [
        0,
        1
      ]
    },
    "string" : {
      "string" : "string",
      "string" : 6,
      "string" : "string",
      "string" : false,
      "string" : false,
      "string" : false,
      "string" : false
    },
    "string" : {
      "string" : "string",
      "string" : 2,
      "string" : "string",
      "string" : false,
      "string" : false,
      "string" : false,
      "string" : false
    },
    "string" : {
      "string" : "string",
      "string" : 36,
      "string" : "string",
      "string" : true,
      "string" : false,
      "string" : false,
      "string" : false,
      "string" : [
        0.20000000298023224,
        0.800000011920929
      ],
      "string" : [
        0,
        0.800000011920929
      ]
    },
    "string" : {
      "string" : "string",
      "string" : 32,
      "string" : "string",
      "string" : false,
      "string" : false,
      "string" : true,
      "string" : false
    }
  },
  "string" : {
    "string" : "string",
    "string" : "string",
    "string" : "string",
    "string" : {
      "string" : [
        0,
        0,
        -201.39999389648438
      ],
      "string" : [
        2.0999999046325684,
        2.0999999046325684,
        -199.89999389648438
      ],
      "string" : [
        2.0999999046325684,
        2.0999999046325684,
        1.5
      ]
    },
    "string" : [
      0.6999999682108561,
      0.6999999682108561,
      0.375
    ],
    "string" : 0.6999999682108561,
    "string" : [],
    "string" : true,
    "string" : 0,
    "string" : 0,
    "string" : 0,
    "string" : 3.5
  },
  "string" : [
    3,
    3,
    4
  ],
  "string" : 1,
  "string" : "string",
  "string" : "string",
  "string" : {
    "string" : {
      "string" : {
        "string" : 0,
        "string" : {},
        "string" : {
          "string" : 0,
          "string" : 0
        },
        "string" : true,
        "string" : true,
        "string" : true,
        "string" : true,
        "string" : true,
        "string" : {
          "string" : [
            0.5,
            0.5,
            -199.9499969482422
          ],
          "string" : [
            1.5999999046325684,
            1.5999999046325684,
            -199.9499969482422
          ]
        },
        "string" : {
          "string" : [
            1.0499999523162842,
            1.0499999523162842,
            -199.9499969482422
          ],
          "string" : 0.7778173918702447
        },
        "string" : 5001,
        "string" : false,
        "string" : {},
        "string" : "string",
        "string" : "string",
        "string" : true,
        "string" : {
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : false,
            "string" : false,
            "string" : false,
            "string" : [
              3,
              9
            ],
            "string" : [
              3
            ],
            "string" : null,
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : false,
            "string" : false,
            "string" : false,
            "string" : [
              1,
              9
            ],
            "string" : [
              1
            ],
            "string" : null,
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : false,
            "string" : false,
            "string" : false,
            "string" : [
              1,
              9
            ],
            "string" : [
              1
            ],
            "string" : null,
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : [
              1,
              4
            ],
            "string" : [
              1
            ],
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          }
        },
        "string" : {
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : [
              1,
              4
            ],
            "string" : [
              1
            ],
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          }
        },
        "string" : {
          "string" : "string",
          "string" : [
            0
          ],
          "string" : 1,
          "string" : 1
        }
      },
      "string" : {
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 4,
          "string" : 108,
          "string" : 0
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 236,
          "string" : 36,
          "string" : 1
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 112,
          "string" : 36,
          "string" : 2
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 148,
          "string" : 8,
          "string" : 3
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 156,
          "string" : 4,
          "string" : 4
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 160,
          "string" : 4,
          "string" : 5
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 164,
          "string" : 8,
          "string" : 6
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 172,
          "string" : 4,
          "string" : 7
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 176,
          "string" : 4,
          "string" : 8
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 180,
          "string" : 8,
          "string" : 9
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 188,
          "string" : 4,
          "string" : 10
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 192,
          "string" : 4,
          "string" : 11
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 196,
          "string" : 16,
          "string" : 12
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 212,
          "string" : 8,
          "string" : 13
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 220,
          "string" : 4,
          "string" : 14
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 224,
          "string" : 4,
          "string" : 15
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 228,
          "string" : 8,
          "string" : 16
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 0,
          "string" : 4,
          "string" : 17
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 272,
          "string" : 4,
          "string" : 18
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 276,
          "string" : 8,
          "string" : 19
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 284,
          "string" : 4,
          "string" : 20
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 288,
          "string" : 4,
          "string" : 21
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 292,
          "string" : 8,
          "string" : 22
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 300,
          "string" : 4,
          "string" : 23
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 304,
          "string" : 4,
          "string" : 24
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 308,
          "string" : 8,
          "string" : 25
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 316,
          "string" : 4,
          "string" : 26
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 320,
          "string" : 4,
          "string" : 27
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 324,
          "string" : 16,
          "string" : 28
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 340,
          "string" : 8,
          "string" : 29
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 348,
          "string" : 4,
          "string" : 30
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 352,
          "string" : 4,
          "string" : 31
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 356,
          "string" : 8,
          "string" : 32
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 364,
          "string" : 4,
          "string" : 33
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 368,
          "string" : 4,
          "string" : 34
        }
      },
      "string" : {
        "string" : {
          "string" : {
            "string" : "string",
            "string" : [
              0
            ],
            "string" : 1,
            "string" : 1
          },
          "string" : "string",
          "string" : "string",
          "string" : 1
        }
      },
      "string" : "string",
      "string" : "string"
    },
    "string" : {
      "string" : {
        "string" : 0,
        "string" : {},
        "string" : {
          "string" : 0,
          "string" : 0
        },
        "string" : true,
        "string" : true,
        "string" : true,
        "string" : true,
        "string" : true,
        "string" : {
          "string" : [
            0.5,
            0.5,
            -201
          ],
          "string" : [
            1.5999999046325684,
            1.5999999046325684,
            -199.9499969482422
          ]
        },
        "string" : {
          "string" : [
            1.0499999523162842,
            1.0499999523162842,
            -200.4749984741211
          ],
          "string" : 0.7778173918702447
        },
        "string" : 5001,
        "string" : false,
        "string" : {},
        "string" : "string",
        "string" : "string",
        "string" : true,
        "string" : {
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : false,
            "string" : false,
            "string" : false,
            "string" : [
              3,
              16
            ],
            "string" : [
              3
            ],
            "string" : null,
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : false,
            "string" : false,
            "string" : false,
            "string" : [
              1,
              16
            ],
            "string" : [
              1
            ],
            "string" : null,
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : false,
            "string" : false,
            "string" : false,
            "string" : [
              1,
              16
            ],
            "string" : [
              1
            ],
            "string" : null,
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : [
              1,
              4
            ],
            "string" : [
              1
            ],
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          }
        },
        "string" : {
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : [
              1,
              4
            ],
            "string" : [
              1
            ],
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          }
        },
        "string" : {
          "string" : "string",
          "string" : [
            0
          ],
          "string" : 1,
          "string" : 1
        }
      },
      "string" : {
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 4,
          "string" : 192,
          "string" : 0
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 348,
          "string" : 64,
          "string" : 1
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 196,
          "string" : 64,
          "string" : 2
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 260,
          "string" : 8,
          "string" : 3
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 268,
          "string" : 4,
          "string" : 4
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 272,
          "string" : 4,
          "string" : 5
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 276,
          "string" : 8,
          "string" : 6
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 284,
          "string" : 4,
          "string" : 7
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 288,
          "string" : 4,
          "string" : 8
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 292,
          "string" : 8,
          "string" : 9
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 300,
          "string" : 4,
          "string" : 10
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 304,
          "string" : 4,
          "string" : 11
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 308,
          "string" : 16,
          "string" : 12
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 324,
          "string" : 8,
          "string" : 13
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 332,
          "string" : 4,
          "string" : 14
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 336,
          "string" : 4,
          "string" : 15
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 340,
          "string" : 8,
          "string" : 16
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 0,
          "string" : 4,
          "string" : 17
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 412,
          "string" : 4,
          "string" : 18
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 416,
          "string" : 8,
          "string" : 19
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 424,
          "string" : 4,
          "string" : 20
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 428,
          "string" : 4,
          "string" : 21
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 432,
          "string" : 8,
          "string" : 22
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 440,
          "string" : 4,
          "string" : 23
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 444,
          "string" : 4,
          "string" : 24
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 448,
          "string" : 8,
          "string" : 25
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 456,
          "string" : 4,
          "string" : 26
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 460,
          "string" : 4,
          "string" : 27
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 464,
          "string" : 16,
          "string" : 28
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 480,
          "string" : 8,
          "string" : 29
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 488,
          "string" : 4,
          "string" : 30
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 492,
          "string" : 4,
          "string" : 31
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 496,
          "string" : 8,
          "string" : 32
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 504,
          "string" : 4,
          "string" : 33
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 508,
          "string" : 4,
          "string" : 34
        }
      },
      "string" : {
        "string" : {
          "string" : {
            "string" : "string",
            "string" : [
              0
            ],
            "string" : 1,
            "string" : 1
          },
          "string" : "string",
          "string" : "string",
          "string" : 1
        }
      },
      "string" : "string",
      "string" : "string"
    },
    "string" : {
      "string" : {
        "string" : 0,
        "string" : {},
        "string" : {
          "string" : 0,
          "string" : 0
        },
        "string" : true,
        "string" : true,
        "string" : true,
        "string" : true,
        "string" : true,
        "string" : {
          "string" : [
            0,
            0,
            -201.39999389648438
          ],
          "string" : [
            2.0999999046325684,
            2.0999999046325684,
            -199.89999389648438
          ]
        },
        "string" : {
          "string" : [
            1.0499999523162842,
            1.0499999523162842,
            -200.64999389648438
          ],
          "string" : 1.4849241730567921
        },
        "string" : 5007,
        "string" : true,
        "string" : {
          "string" : {
            "string" : 5007,
            "string" : [
              0,
              384,
              384,
              432
            ]
          }
        },
        "string" : "string",
        "string" : "string",
        "string" : true,
        "string" : {
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : false,
            "string" : false,
            "string" : false,
            "string" : [
              3,
              128
            ],
            "string" : [
              3
            ],
            "string" : null,
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : false,
            "string" : false,
            "string" : false,
            "string" : [
              4,
              128
            ],
            "string" : [
              4
            ],
            "string" : null,
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : false,
            "string" : 1,
            "string" : false,
            "string" : [
              1,
              128
            ],
            "string" : [
              1
            ],
            "string" : null,
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : false,
            "string" : false,
            "string" : false,
            "string" : [
              1,
              432
            ],
            "string" : [
              1
            ],
            "string" : null,
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : false,
            "string" : false,
            "string" : false,
            "string" : [
              4,
              128
            ],
            "string" : [
              4
            ],
            "string" : null,
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          }
        },
        "string" : {
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : [
              1,
              4
            ],
            "string" : [
              1
            ],
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          },
          "string" : {
            "string" : "string",
            "string" : 0,
            "string" : true,
            "string" : false,
            "string" : false,
            "string" : "string",
            "string" : "string",
            "string" : [
              1,
              0
            ],
            "string" : 0,
            "string" : 1,
            "string" : 0,
            "string" : "string"
          }
        },
        "string" : {
          "string" : "string",
          "string" : [
            4,
            2,
            6,
            0,
            2,
            4,
            7,
            3,
            5,
            5,
            3,
            1,
            0,
            5,
            1,
            4,
            5,
            0,
            6,
            3,
            7,
            2,
            3,
            6,
            2,
            1,
            3,
            0,
            1,
            2,
            4,
            7,
            5,
            6,
            7,
            4
          ],
          "string" : 36,
          "string" : [
            6,
            6,
            6,
            6,
            6,
            6
          ],
          "string" : 12,
          "string" : 24,
          "string" : 8
        }
      },
      "string" : {
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 4,
          "string" : 1536,
          "string" : 0
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 5900,
          "string" : 2048,
          "string" : 1
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 1540,
          "string" : 512,
          "string" : 2
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 2052,
          "string" : 1728,
          "string" : 3
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 3780,
          "string" : 2048,
          "string" : 4
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 5828,
          "string" : 8,
          "string" : 5
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 5836,
          "string" : 4,
          "string" : 6
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 5840,
          "string" : 4,
          "string" : 7
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 5844,
          "string" : 8,
          "string" : 8
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 5852,
          "string" : 4,
          "string" : 9
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 5856,
          "string" : 4,
          "string" : 10
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 5860,
          "string" : 8,
          "string" : 11
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 5868,
          "string" : 4,
          "string" : 12
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 5872,
          "string" : 4,
          "string" : 13
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 5876,
          "string" : 8,
          "string" : 14
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 5884,
          "string" : 4,
          "string" : 15
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 5888,
          "string" : 4,
          "string" : 16
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 5892,
          "string" : 8,
          "string" : 17
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 0,
          "string" : 4,
          "string" : 18
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 7948,
          "string" : 4,
          "string" : 19
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 7952,
          "string" : 8,
          "string" : 20
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 7960,
          "string" : 4,
          "string" : 21
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 7964,
          "string" : 4,
          "string" : 22
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 7968,
          "string" : 8,
          "string" : 23
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 7976,
          "string" : 4,
          "string" : 24
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 7980,
          "string" : 4,
          "string" : 25
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 7984,
          "string" : 8,
          "string" : 26
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 7992,
          "string" : 4,
          "string" : 27
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 7996,
          "string" : 4,
          "string" : 28
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 8000,
          "string" : 16,
          "string" : 29
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 8016,
          "string" : 8,
          "string" : 30
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 8024,
          "string" : 4,
          "string" : 31
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 8028,
          "string" : 4,
          "string" : 32
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 8032,
          "string" : 8,
          "string" : 33
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 8040,
          "string" : 4,
          "string" : 34
        },
        "string" : {
          "string" : "string",
          "string" : 4,
          "string" : 8044,
          "string" : 4,
          "string" : 35
        }
      },
      "string" : {
        "string" : {
          "string" : {
            "string" : "string",
            "string" : [
              4,
              2,
              6,
              0,
              2,
              4,
              7,
              3,
              5,
              5,
              3,
              1,
              0,
              5,
              1,
              4,
              5,
              0,
              6,
              3,
              7,
              2,
              3,
              6,
              2,
              1,
              3,
              0,
              1,
              2,
              4,
              7,
              5,
              6,
              7,
              4
            ],
            "string" : 36,
            "string" : [
              6,
              6,
              6,
              6,
              6,
              6
            ],
            "string" : 12,
            "string" : 24,
            "string" : 8
          },
          "string" : "string",
          "string" : "string",
          "string" : 0
        },
        "string" : {
          "string" : "string",
          "string" : true,
          "string" : false,
          "string" : null,
          "string" : null,
          "string" : null,
          "string" : true
        },
        "string" : {
          "string" : "string",
          "string" : true,
          "string" : false,
          "string" : null,
          "string" : null,
          "string" : null,
          "string" : true
        }
      },
      "string" : "string",
      "string" : "string"
    }
  },
  "string" : {
    "string" : {
      "string" : {
        "string" : "string",
        "string" : 4,
        "string" : 0,
        "string" : 224
      },
      "string" : {
        "string" : "string",
        "string" : 4,
        "string" : 224,
        "string" : 512
      },
      "string" : {
        "string" : "string",
        "string" : 4,
        "string" : 736,
        "string" : 64
      },
      "string" : {
        "string" : "string",
        "string" : 4,
        "string" : 800,
        "string" : 64
      }
    },
    "string" : {
      "length" : 3,
      "string" : "string",
      "string" : 4,
      "string" : 1,
      "string" : 1,
      "string" : 0,
      "string" : {
        "string" : "string"
      }
    },
    "string" : "string"
  }
}

//

function toJson( test )
{

  test.case = 'trivial'; /* */

  var expected = '[ ' + _.arrayFromRange([ 1,100 ]).join( ', ' ) + ' ]';
  var src = _.arrayFromRange([ 1,100 ]);
  var json = _.toJson( src );
  test.identical( json , expected );

  var got = _.exec({ code : json, prependingReturn : 1 });
  var expected = src;
  test.identical( got , expected );

  test.case = 'long object'; /* */

  var object =
  {
    a : "swof",
    b : 96,
    c : "swof.attribute",
    d : false,
    e : false,
    f : false,
    g : false,
    h : [],
    i : {},
    j : 13,
  }

  for( var i = 0 ; i < 100 ; i++ )
  object[ 'field' + i ] = i;

  var src =
  {
    object : { object : { object : { object : { object : { object }}}}}
  }

  var json = _.toJson( src );
  var got = _.exec({ code : json, prependingReturn : 1 });
  var expected = src;
  test.identical( got , expected );

  test.case = 'object with length'; /* */

  var src = {};
  src.length = 4;
  src.object = {};

  var json = _.toJson( src );
  var got = _.exec({ code : json, prependingReturn : 1 });
  var expected = src;
  test.identical( got , expected );

  test.case = 'object with length'; /* */

  var object =
  {
    a : "swof",
    b : 96,
    c : "swof.attribute",
    d : false,
    e : false,
    f : false,
    g : false,
    h : [],
    i : {},
    j : 13,
    length : 4,
  }

  var src = Object.create( null );
  src.length = 4;
  src.object = object;

  var json = _.toJson( src );
  var got = _.exec({ code : json, prependingReturn : 1 });
  var expected = src;
  test.identical( got , expected );

  test.case = 'comlex'; /* */

  var src = complexData;
  var json = _.toJson( src );
  var got = _.exec({ code : json, prependingReturn : 1 });
  var expected = src;
  test.identical( got , expected );

}

//

var Self =
{

  name : 'Tools.base.l4.String.ToJson',
  silencing : 1,
  // verbosity : 7,

  tests :
  {
    toJson,
  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
