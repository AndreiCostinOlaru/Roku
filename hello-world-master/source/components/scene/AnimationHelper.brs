function createButtonsRowListAnimation(layoutGroup as Object) as Object
    layoutTranslationRowListFocus = initializeTranslationAnimation(layoutGroup, 1000, 1000, 1000, 0)
    return layoutTranslationRowListFocus
end function

function initializeTranslationAnimation(target as Object, originX as Integer, originY as Integer, destinationX as Integer, destinationY as Integer) as Object
    translateAnim = createTranslationAnimation(1, "linear")
    vector2DInterpolator = createPositionInterpolator(target, originX, originY, destinationX, destinationY)
    translateAnim.appendChild(vector2DInterpolator)
    return translateAnim
end function

function createTranslationAnimation(duration as Integer, easeFunction as String) as Object
    translateAnim = createObject("roSGNode", "Animation")
    translateAnim.duration = duration
    translateAnim.easeFunction = easeFunction
    return translateAnim
end function

function createPositionInterpolator(target as Object, originX as Integer, originY as Integer, destinationX as Integer, destinationY as Integer) as Object
    interpolator = createObject("roSGNode", "Vector2DFieldInterpolator")
    interpolator.key = [0.0, 0.5, 1.0]
    interpolator.keyValue = generateKeyValues(originX, originY, destinationX, destinationY)
    interpolator.fieldToInterp = target.id + ".translation"
    interpolator.reverse = true
    return interpolator
end function

function generateKeyValues(originX as Integer, originY as Integer, destinationX as Integer, destinationY as Integer) as Object
    meanX = (originX + destinationX) / 2
    meanY = (originY + destinationY) / 2
    return [[originX, originY], [meanX, meanY], [destinationX, destinationY]]
end function

sub reverseStartAnimation(animation as Object)
    vector2DFieldInterpolator = animation.getChild(0)
    vector2DFieldInterpolator.reverse = not vector2DFieldInterpolator.reverse
    animation.control = "start"
end sub
