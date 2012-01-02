var accordionTop = 30;
$(function () {
	$(".accordionHeader").hover(function()
	{
		$(this).addClass("accordionHover");
	}, function()
    {
		$(this).removeClass("accordionHover");
	}); 
    $(".accordionHeader").click(function () {
        var currentElement = $(this);
		$(".accordionHeader").removeClass("accordionActive");
        var currentDiv = currentElement.parent().find(".accordionContent");
        var first = true;
        if ($(".accordionContent:visible").length > 0 && !currentDiv.equals($(".accordionContent:visible"))) {
            first = false;
			$(this).addClass("accordionActive");
            $.scrollTo({ top:($(".accordionContent:visible").parent().offset().top + accordionTop) + 'px', left:$(".accordionContent:visible").parent().offset().left + 'px'}, 500, { onAfter: function () {
                $(".accordionContent:visible").slideUp(500, function () {
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
	var currentDiv = currentElement.parent().find(".accordionHeader");
	var currentPic = currentElement.parent().find(".accordionContent");
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

$(function() {
	initCarousel();
});
//Carousel
var carouselPanels;
var carouselNav;
var currentSlid;
function initCarousel(){
	if($("#carouselContainer").length > 0)
	{
		carouselPanels = $("#carouselContainer div.carouselContentWap");
		carouselNav = $("#carousel div.carouselItem");
		currentSlid = 0;
		for(var i=0; i < carouselNav.length; i=i+1)   {
			carouselNav[i].indexNum = i; 
	
			carouselNav[i].onclick = function() {
				slideView(currentSlid, this.indexNum);
			}
		}
		
		$("#carousel div.preView").click(function(){
			preView();
		});
		
		$("#carousel div.nextView").click(function(){
			nextView();
		});
	}
	
}

function preView()
{
	if(currentSlid == 0)
		slideView(currentSlid, carouselNav.length - 1);
	else
		slideView(currentSlid, currentSlid - 1);
}

function nextView()
{
	if(currentSlid == carouselNav.length - 1)
		slideView(currentSlid, 0);
	else
		slideView(currentSlid, currentSlid + 1);
}

function slideView(fromIndex, toIndex)
{
	if(fromIndex == toIndex)
		return;
	else if(fromIndex > toIndex)
	{
		$(carouselPanels[fromIndex]).css("marginLeft", "0px");
		$(carouselPanels[fromIndex]).animate({
			marginLeft: "2000px"
		  }, 500, function() {
			  $(carouselPanels[fromIndex]).removeClass("active");
			  $(carouselNav[fromIndex]).removeClass("active");
		  });
		  $(carouselPanels[toIndex]).css("marginLeft", "-2000px");
		  $(carouselPanels[toIndex]).animate({
			marginLeft: "0px"
		  }, 500, function() {
			 $(carouselPanels[toIndex]).addClass("active");
			 $(carouselNav[toIndex]).addClass("active");
		  });				
	}
	else
	{
		$(carouselPanels[fromIndex]).css("marginLeft", "0px");
		$(carouselPanels[fromIndex]).animate({
			marginLeft: "-2000px"
		  }, 500, function() {
			  $(carouselPanels[fromIndex]).removeClass("active");
			  $(carouselNav[fromIndex]).removeClass("active");
		  });
		  $(carouselPanels[toIndex]).css("marginLeft", "2000px");
		  $(carouselPanels[toIndex]).css("visibility", "visible");
		  $(carouselPanels[toIndex]).animate({
			marginLeft: "0px"
		  }, 500, function() {
			  $(carouselPanels[toIndex]).addClass("active");
			  $(carouselNav[toIndex]).addClass("active");
		  });
	}
	currentSlid = toIndex;
}