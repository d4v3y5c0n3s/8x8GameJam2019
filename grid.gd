extends Node2D

onready var grid = get_children()#  the collection of all the points

#  gets all 8 points that are around the character
func check_nearby(point):#  used by characters to check their surroundings so that they turn when they need to
	#  the variables of the nearby points
	var top_left
	var top_center
	var top_right
	var left
	var right
	var bottom_left
	var bottom_center
	var bottom_right
	
	var center_row = []
	
	var row_above = point.y - 1000
	var row_below = point.y + 1000
	var left_collumn = point.x - 1000
	var right_collumn = point.x + 1000
	for n in grid:#  for the rows above, below, and at the point's y-value; along with
		if n.position.y == point.y and point.x != n.position.x:#  adds the row at the same level as the point, makes sure the center isn't appended
			center_row.append(n)
		elif n.position.y < point.y and n.position.y > row_above:#  if y value is above the point but closer to the point than the current value of row_above, make the y-value the new row above
			row_above = n.position.y
		elif n.position.y > point.y and n.position.y < row_below:#  same deal as above, except that this pertains to the value 'row_below'
			row_below = n.position.y
		elif n.position.x < point.x and n.position.x > left_collumn:
			left_collumn = n.position.x
		elif n.position.x > point.x and n.position.x < right_collumn:
			right_collumn = n.position.x
	
	for s in grid:#  sets the nearby positions
		if s.position == Vector2(left_collumn, row_above):#  top_left
			top_left = s
		elif s.position == Vector2(point.x, row_above):#  top_center
			top_center = s
		elif s.position == Vector2(right_collumn, row_above):#  top_right
			top_right = s
		elif s.position == Vector2(left_collumn, point.y):#  left
			left = s
		elif s.position == Vector2(right_collumn, point.y):#  right
			right = s
		elif s.position == Vector2(left_collumn, row_below):#  bottom_left
			bottom_left = s
		elif s.position == Vector2(point.x, row_below):#  bottom_center
			bottom_center = s
		elif s.position == Vector2(right_collumn, row_below):#  bottom_right
			bottom_right = s
	
	return [top_left, top_center, top_right, left, right, bottom_left, bottom_center, bottom_right]

#  used by enemies to spot enemies who are ahead
func check_ahead(direction, point):#  0 = left, 1 = up, 2 = right, 3 = down
	var line_of_points = []
	
	match direction:
		0:#  left
			for p in grid:
				if p.position.y == point.y and p.position.x != point.x and not p.position.x > point.x:#  ensures that the only points returned are from the left of the point
					line_of_points.append(p)
			
			#  before returning line_of_points, remove all points which go through walls
			line_of_points.sort_custom(los_filter_highest_x, "sort")#  here, you are looking for the highest x-value
			var hit_wall = false
			for l in line_of_points:
				if not hit_wall and not l.is_accessible():
					hit_wall = true
				elif not hit_wall:
					l.light_up = true#  lights up the point for the frame
				
				if hit_wall:
					line_of_points.erase(l)
			
		2:#  right
			for p in grid:
				if p.position.y == point.y and p.position.x != point.x and not p.position.x < point.x:#  
					line_of_points.append(p)
			
			#  before returning line_of_points, remove all points which go through walls
			line_of_points.sort_custom(los_filter_lowest_x, "sort")#  here, you are looking for the the lowest x-value
			var hit_wall = false
			for l in line_of_points:
				if not hit_wall and not l.is_accessible():
					hit_wall = true
				elif not hit_wall:
					l.light_up = true#  lights up the point for the frame
				
				if hit_wall:
					line_of_points.erase(l)
			
		1:#  up
			for p in grid:
				if p.position.x == point.x and p.position.y != point.y and not p.position.y < point.y:#  
					line_of_points.append(p)
			
			#  before returning line_of_points, remove all points which go through walls
			line_of_points.sort_custom(los_filter_lowest_y, "sort")#  here, you are looking for the highest y-value
			var hit_wall = false
			for l in line_of_points:
				if not hit_wall and not l.is_accessible():
					hit_wall = true
				elif not hit_wall:
					l.light_up = true#  lights up the point for the frame
				
				if hit_wall:
					line_of_points.erase(l)
			
		3:#  down
			for p in grid:
				if p.position.x == point.x and p.position.y != point.y and not p.position.y > point.y:#  
					line_of_points.append(p)
			
			#  before returning line_of_points, remove all points which go through walls
			line_of_points.sort_custom(los_filter_highest_y, "sort")#  here, you are looking for the lowest y-value
			var hit_wall = false
			for l in line_of_points:
				if not hit_wall and not l.is_accessible():
					hit_wall = true
				elif not hit_wall:
					l.light_up = true#  lights up the point for the frame
				
				if hit_wall:
					line_of_points.erase(l)
	
	return line_of_points

class los_filter_highest_x:
	static func sort(a, b):
		if a.position.x > b.position.x:
			return true
		return false
class los_filter_lowest_x:
	static func sort(a, b):
		if a.position.x < b.position.x:
			return true
		return false
class los_filter_lowest_y:
	static func sort(a, b):
		if a.position.y < b.position.y:
			return true
		return false
class los_filter_highest_y:
	static func sort(a, b):
		if a.position.y > b.position.y:
			return true
		return false
