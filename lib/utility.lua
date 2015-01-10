function rPrint(s, l, i) -- recursive Print (structure, limit, indent)
  l = (l) or 100; i = i or ""; -- default item limit, indent string
  if (l<1) then print "ERROR: Item limit reached."; return l-1 end;
    local ts = type(s);
    if (ts ~= "table") then print (i,ts,s); return l-1 end
    print (i,ts); -- print "table"
    for k,v in pairs(s) do -- print "[KEY] VALUE"
      l = rPrint(v, l, i.."\t["..tostring(k).."]");
      if (l < 0) then break end
    end
    return l
  end	

  function killObject(obj)
    display.remove(obj);obj= nil 
  end

--circle-based collision detection
  function hasCollidedCircle( obj1, obj2 )
    if ( obj1 == nil or not obj1.contentWidth ) then  --make sure the first object exists
      return false
    end
    if ( obj2 == nil or not obj2.contentWidth ) then  --make sure the other object exists
      return false
    end

    local dx = obj1.x - obj2.x
    local dy = obj1.y - obj2.y

    local distance = math.sqrt( dx*dx + dy*dy )
    local objectSize = (obj2.contentWidth/2) + (obj1.contentWidth/2)

    if ( distance < objectSize ) then
      return true
    end
    return false
  end

--rectangle-based collision detection
  function hasCollided( obj1, obj2 )
    if ( obj1 == nil ) then  --make sure the first object exists
      return false
    end
    if ( obj2 == nil ) then  --make sure the other object exists
      return false
    end

    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax

    return (left or right) and (up or down)
  end








