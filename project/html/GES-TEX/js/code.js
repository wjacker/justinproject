var accordionTop = 30;
$(function () {
	$(".work").hover(function()
	{
		$(this).addClass("accordionHover");
	}, function()
    {
		$(this).removeClass("accordionHover");
	}); 
    $(".work").click(function () {
        var currentElement = $(this);
		$(".work").removeClass("accordionActive");
        var currentDiv = currentElement.parent().find(".pics");
        var first = true;
        if ($(".pics:visible").length > 0 && !currentDiv.equals($(".pics:visible"))) {
            first = false;
			$(this).addClass("accordionActive");
            $.scrollTo({ top:($(".pics:visible").parent().offset().top + accordionTop) + 'px', left:$(".pics:visible").parent().offset().left + 'px'}, 500, { onAfter: function () {
                $(".pics:visible").slideUp(500, function () {
                    $.scrollTo({top:(currentElement.offset().top + accordionTop ) + 'px', left:currentElement.offset().left + 'px'}, 500, { onAfter: function () {
                        currentDiv.slideDown(500, function () {
                            $.scrollTo({top:(currentElement.offset().top + accordionTop ) + 'px', left:currentElement.offset().left + 'px'}, { speed: 500 });
                        });
                    } 
                    });
                });
            }
            });
        }

        if (currentDiv.is(":hidden") && first) {
			$(this).addClass("accordionActive");
            currentDiv.slideDown(500, function () {
                $.scrollTo({top:(currentElement.offset().top + accordionTop ) + 'px', left:currentElement.offset().left + 'px'}, { speed: 500 });
            });
        }
        else if (first) {
            currentDiv.slideUp(500, function () {
                $.scrollTo({top:(currentElement.offset().top + accordionTop ) + 'px', left:currentElement.offset().left + 'px'}, 500);
            });    
        }
    });
	
	$(".close").click(function (){
	var currentElement = $(this).parent();
	var currentDiv = currentElement.parent().find(".work");
	var currentPic = currentElement.parent().find(".pics");
	$.scrollTo({top:(currentDiv.offset().top + accordionTop ) + 'px', left:currentDiv.offset().left + 'px'}, 500, { onAfter: function () {
    currentPic.slideUp(500);
	}});
	});

});

$.fn.equals = function (compareTo) {
    if (!compareTo || !compareTo.length || this.length != compareTo.length) {
        return false;
    }
    for (var i = 0; i < this.length; i++) {
        if (this[i] !== compareTo[i]) {
            return false;
        }
    }
    return true;
}