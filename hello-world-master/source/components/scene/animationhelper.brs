function translationAnimation(target as Object, originX as Integer, originY as Integer, newX as Integer, newY as Integer) as Object
    translateAnim = createObject("roSGNode", "Animation")
    translateAnim.duration = 1
    translateAnim.easeFunction = "linear"
    
    vector2DFieldInterpolator = createObject("roSGNode", "Vector2DFieldInterpolator")
    vector2DFieldInterpolator.key = [0.0, 1.0]
    vector2DFieldInterpolator.keyValue = [[originX, originY], [newX, newY]]
    vector2DFieldInterpolator.fieldToInterp = target.id+".translation"

    translateAnim.appendChild(vector2DFieldInterpolator)
    return translateAnim
end function

function parallelAnimation(animation1 as Object, animation2 as Object, animation3 as Object) as Object
    parallelAnim = createObject("roSGNode", "ParallelAnimation")
    parallelAnim.appendChild(animation1)
    parallelAnim.appendChild(animation2)
    parallelAnim.appendChild(animation3)
    return parallelAnim
end function

function buttonsRowListAnimation(videoButton as Object, gridButton as Object, rowList as Object) as Object
    rowListTranslationCenterUp = translationAnimation(rowList, 20, 386, 20, -320)
    videoButtonTranslationDownCenter = translationAnimation(videoButton, 700, 1280, 700, 420)
    gridButtonTranslationDownCenter = translationAnimation(gridButton, 940, 1280, 940, 420)
    buttonsFocusAnimation = parallelAnimation(rowListTranslationCenterUp, videoButtonTranslationDownCenter, gridButtonTranslationDownCenter)

    rowListTranslationUpCenter = translationAnimation(rowList, 20, -320, 20, 386)
    videoButtonTranslationCenterDown = translationAnimation(videoButton, 700, 420, 700, 1280)
    gridButtonTranslationCenterDown = translationAnimation(gridButton, 940, 420, 940, 1280)
    rowListFocusAnimation = parallelAnimation(rowListTranslationUpCenter, videoButtonTranslationCenterDown, gridButtonTranslationCenterDown)

    return [buttonsFocusAnimation, rowListFocusAnimation]
end function
