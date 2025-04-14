function createTranslationAnimation(target as Object, originX as Integer, originY as Integer, destinationX as Integer, destinationY as Integer) as Object
    translateAnim = createObject("roSGNode", "Animation")
    translateAnim.duration = 1
    translateAnim.easeFunction = "linear"

    vector2DFieldInterpolator = createObject("roSGNode", "Vector2DFieldInterpolator")
    vector2DFieldInterpolator.key = [0.0, 0.5, 1.0]
    meanX = (originX + destinationX) / 2
    meanY = (originY + destinationY) / 2
    vector2DFieldInterpolator.keyValue = [[originX, originY], [meanX, meanY], [destinationX, destinationY]]
    vector2DFieldInterpolator.fieldToInterp = target.id+".translation"
    vector2DFieldInterpolator.reverse = true

    translateAnim.appendChild(vector2DFieldInterpolator)
    return translateAnim
end function

function createButtonsRowListAnimation(layoutGroup as Object) as Object
    layoutTranslationRowListFocus = createTranslationAnimation(layoutGroup, 980, 0, 980, 1000)
    return layoutTranslationRowListFocus
end function

sub reverseStartAnimation(animation as Object)
    vector2DFieldInterpolator = animation.getChild(0)
    vector2DFieldInterpolator.reverse = not vector2DFieldInterpolator.reverse
    animation.control = "start"
end sub
