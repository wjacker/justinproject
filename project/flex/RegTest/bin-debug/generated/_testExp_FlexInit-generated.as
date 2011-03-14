package {
import flash.display.DisplayObject;
import flash.utils.*;
import mx.core.IFlexModuleFactory;
import mx.styles.IStyleManager2;
import mx.events.Request;
import mx.styles.StyleManagerImpl;
import mx.managers.systemClasses.ChildManager;
import mx.core.TextFieldFactory; TextFieldFactory;
import flash.system.*
import mx.accessibility.LabelAccImpl;
import mx.accessibility.ButtonAccImpl;
import mx.accessibility.UIComponentAccProps;
import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import mx.utils.ObjectProxy;
import mx.effects.EffectManager;
import mx.core.mx_internal;

[Mixin]
public class _testExp_FlexInit
{
   public function _testExp_FlexInit()
   {
       super();
   }
   public static function init(fbs:IFlexModuleFactory):void
   {
       new ChildManager(fbs);
       var styleManager:IStyleManager2;
       styleManager = new StyleManagerImpl(fbs);
       EffectManager.mx_internal::registerEffectTrigger("addedEffect", "added");
       EffectManager.mx_internal::registerEffectTrigger("creationCompleteEffect", "creationComplete");
       EffectManager.mx_internal::registerEffectTrigger("focusInEffect", "focusIn");
       EffectManager.mx_internal::registerEffectTrigger("focusOutEffect", "focusOut");
       EffectManager.mx_internal::registerEffectTrigger("hideEffect", "hide");
       EffectManager.mx_internal::registerEffectTrigger("mouseDownEffect", "mouseDown");
       EffectManager.mx_internal::registerEffectTrigger("mouseUpEffect", "mouseUp");
       EffectManager.mx_internal::registerEffectTrigger("moveEffect", "move");
       EffectManager.mx_internal::registerEffectTrigger("removedEffect", "removed");
       EffectManager.mx_internal::registerEffectTrigger("resizeEffect", "resize");
       EffectManager.mx_internal::registerEffectTrigger("rollOutEffect", "rollOut");
       EffectManager.mx_internal::registerEffectTrigger("rollOverEffect", "rollOver");
       EffectManager.mx_internal::registerEffectTrigger("showEffect", "show");
       // trace("Flex accessibility startup: " + Capabilities.hasAccessibility);
       if (Capabilities.hasAccessibility) {
          mx.accessibility.LabelAccImpl.enableAccessibility();
          mx.accessibility.ButtonAccImpl.enableAccessibility();
          mx.accessibility.UIComponentAccProps.enableAccessibility();
       }
       try {
       if (flash.net.getClassByAlias("flex.messaging.io.ObjectProxy") == null){
           flash.net.registerClassAlias("flex.messaging.io.ObjectProxy", mx.utils.ObjectProxy);}
       } catch (e:Error) {
           flash.net.registerClassAlias("flex.messaging.io.ObjectProxy", mx.utils.ObjectProxy); }
       var styleNames:Array = ["lineHeight", "unfocusedTextSelectionColor", "kerning", "textRollOverColor", "digitCase", "inactiveTextSelectionColor", "textDecoration", "justificationRule", "dominantBaseline", "fontThickness", "trackingRight", "blockProgression", "leadingModel", "textAlignLast", "textAlpha", "letterSpacing", "chromeColor", "rollOverColor", "fontSize", "baselineShift", "focusedTextSelectionColor", "paragraphEndIndent", "fontWeight", "breakOpportunity", "leading", "renderingMode", "symbolColor", "fontSharpness", "barColor", "modalTransparencyDuration", "paragraphStartIndent", "justificationStyle", "layoutDirection", "contentBackgroundColor", "paragraphSpaceAfter", "contentBackgroundAlpha", "textRotation", "fontAntiAliasType", "cffHinting", "direction", "errorColor", "locale", "digitWidth", "backgroundDisabledColor", "modalTransparencyColor", "ligatureLevel", "firstBaselineOffset", "textIndent", "themeColor", "fontLookup", "tabStops", "modalTransparency", "paragraphSpaceBefore", "textAlign", "fontFamily", "textSelectedColor", "lineThrough", "whiteSpaceCollapse", "fontGridFitType", "alignmentBaseline", "trackingLeft", "fontStyle", "dropShadowColor", "accentColor", "disabledColor", "modalTransparencyBlur", "textJustify", "focusColor", "color", "alternatingItemColors", "typographicCase"];

       for (var i:int = 0; i < styleNames.length; i++)
       {
          styleManager.registerInheritingStyle(styleNames[i]);
       }
   }
}  // FlexInit
}  // package
