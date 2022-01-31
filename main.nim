import system
import strformat
import math

type RGB = tuple[r: float, g: float, b: float]
type Vec2 = tuple[x: float, y: float]

const WIDTH = 512
const HEIGHT = 512

proc `+`(a, b: Vec2): Vec2 = (a.x + b.x, a.y + b.y)
proc `-`(a, b: Vec2): Vec2 = (a.x - b.x, a.y - b.y)
proc `*`(a, b: Vec2): Vec2 = (a.x * b.x, a.y * b.y)
proc `/`(a, b: Vec2): Vec2 = (a.x / b.x, a.y / b.y)

proc stripes(u, v: float): RGB =
  let n = 20.0
  ((sin(u * n) + 1.0) * 0.5,
   (sin((u + v) * n) + 1.0) * 0.5,
   (cos(v * n) + 1.0) * 0.5)

proc japan(u, v: float): RGB =
  let cx = 0.5
  let cy = 0.5
  let dx = cx - u
  let dy = cy - v
  let r = 0.25
  let c = dx * dx + dy * dy > r * r
  (1.0, float(c), float(c))

proc main(): void =
  let f = open("output.ppm", fmWrite)
  defer: f.close()
  f.writeLine("P6")
  f.writeLine(fmt"{WIDTH} {HEIGHT} 255")
  for y in 0..<HEIGHT:
    for x in 0..<WIDTH:
      let u = float(x) / float(WIDTH)
      let v = float(y) / float(HEIGHT)
      let (r, g, b) = japan(u, v)
      f.write(chr(int(r * 255.0)))
      f.write(chr(int(g * 255.0)))
      f.write(chr(int(b * 255.0)))

when isMainModule:
  main()
