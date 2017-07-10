module Constants
  MOVEMENTS = {
    'NORTH' => [0, 1],
    'SOUTH' => [0, -1],
    'EAST'  => [1, 0],
    'WEST'  => [-1, 0]
  }.freeze

  DIRECTIONS = {
    'NORTH' => {
      'LEFT' => 'WEST',
      'RIGHT' => 'EAST'
    },
    'SOUH' => {
      'LEFT' => 'WEST',
      'RIGHT' => 'EAST'
    },
    'EAST' => {
      'LEFT' => 'NORTH',
      'RIGHT' => 'SOUTH'
    },
    'WEST' => {
      'LEFT' => 'NORTH',
      'RIGHT' => 'SOUTH'
    }
  }.freeze
end