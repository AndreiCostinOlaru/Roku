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

    translateAnim.appendChild(vector2DFieldInterpolator)
    return translateAnim
end function

function createParallelAnimation(animation1 as Object, animation2 as Object, animation3 as Object) as Object
    parallelAnim = createObject("roSGNode", "ParallelAnimation")
    parallelAnim.appendChild(animation1)
    parallelAnim.appendChild(animation2)
    parallelAnim.appendChild(animation3)
    return parallelAnim
end function

function createButtonsRowListAnimation(videoButton as Object, gridButton as Object, rowList as Object) as Object
    rowListTranslationCenterUp = createTranslationAnimation(rowList, 20, 386, 20, -320)
    videoButtonTranslationDownCenter = createTranslationAnimation(videoButton, 700, 1280, 700, 420)
    gridButtonTranslationDownCenter = createTranslationAnimation(gridButton, 940, 1280, 940, 420)
    buttonsFocusAnimation = createParallelAnimation(rowListTranslationCenterUp, videoButtonTranslationDownCenter, gridButtonTranslationDownCenter)

    rowListTranslationUpCenter = createTranslationAnimation(rowList, 20, -320, 20, 386)
    videoButtonTranslationCenterDown = createTranslationAnimation(videoButton, 700, 420, 700, 1280)
    gridButtonTranslationCenterDown = createTranslationAnimation(gridButton, 940, 420, 940, 1280)
    rowListFocusAnimation = createParallelAnimation(rowListTranslationUpCenter, videoButtonTranslationCenterDown, gridButtonTranslationCenterDown)

    return [buttonsFocusAnimation, rowListFocusAnimation]
end function
