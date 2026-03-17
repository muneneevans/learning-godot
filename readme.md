# Raycast vehicles

### Spring
- has a `rest_position`
- applies a force to `push` or `pull` it towards the `rest_position`
- `force` is determined by `offset_distance * stiffness`
- Car suspensions use a `damp spring`
- - `force` is determined by `offset_distance * stiffness - damp_strength * relative_speed`
- `Raycasts` are used to mimick springs

