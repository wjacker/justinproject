package com.lombardrisk.jupiter.view
{
    import com.lombardrisk.jupiter.ApplicationFacade;
    import com.lombardrisk.jupiter.model.CashflowCategoryProxy;
    import com.lombardrisk.jupiter.model.CountryProxy;
    import com.lombardrisk.jupiter.model.CurrencyProxy;
    import com.lombardrisk.jupiter.model.GLCProxy;
    import com.lombardrisk.jupiter.model.IndustryProxy;
    import com.lombardrisk.jupiter.model.InstitutionProxy;
    import com.lombardrisk.jupiter.model.RegionProxy;
    import com.lombardrisk.jupiter.model.ScenarioProxy;
    import com.lombardrisk.jupiter.model.vo.ScenarioRule;
    import com.lombardrisk.jupiter.util.JupiterConstants;
    import com.lombardrisk.jupiter.view.components.scenariomanagement.FilterSettingPanel;
    import com.lombardrisk.jupiter.view.components.scenariomanagement.GetFieldDataSource;
    
    import flash.events.Event;
    
    import mx.collections.ArrayCollection;
    import mx.collections.XMLListCollection;
    import mx.controls.RadioButton;
    
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.mediator.Mediator;

    public class FilterSettingMediator extends Mediator implements IMediator
    {
        public static const NAME:String="FilterSettingMediator";

        private var currencyproxy:CurrencyProxy;
        private var countryproxy:CountryProxy;
        private var industryProxy:IndustryProxy;
        private var institutionProxy:InstitutionProxy;
        private var regionProxy:RegionProxy;
        private var glcProxy:GLCProxy;
        private var cashflowCategoryProxy : CashflowCategoryProxy;
		private var scenarioProxy:ScenarioProxy;
		
        public function FilterSettingMediator(viewComponent:Object = null)
        {
            super(NAME, viewComponent);
            currencyproxy=CurrencyProxy(facade.retrieveProxy(CurrencyProxy.NAME));
            countryproxy=CountryProxy(facade.retrieveProxy(CountryProxy.NAME));
            industryProxy=facade.retrieveProxy(IndustryProxy.NAME) as IndustryProxy;
            institutionProxy=InstitutionProxy(facade.retrieveProxy(InstitutionProxy.NAME)) as InstitutionProxy;
            regionProxy=RegionProxy(facade.retrieveProxy(RegionProxy.NAME));
            glcProxy=GLCProxy(facade.retrieveProxy(GLCProxy.NAME));
            cashflowCategoryProxy = CashflowCategoryProxy(facade.retrieveProxy(CashflowCategoryProxy.NAME));
			scenarioProxy = ScenarioProxy(facade.retrieveProxy(ScenarioProxy.NAME));
			
            //filterSettingPanel.addEventListener(JupiterConstants.CURRENCY_GET, getCurrency);
            //filterSettingPanel.addEventListener(JupiterConstants.COUNTRY_GET, getCountry);
            //filterSettingPanel.addEventListener(JupiterConstants.INDUSTRY_GET, getIndustry);
            //filterSettingPanel.addEventListener(JupiterConstants.INDUSTRY_TREE_GET, getIndustryTree);
            //filterSettingPanel.addEventListener(JupiterConstants.INSTITUTION_GET, getInstitution);
            //filterSettingPanel.addEventListener(JupiterConstants.REGION_GET, getRegion);
            filterSettingPanel.addEventListener(JupiterConstants.SQLLIST_SAVE, saveFilterSetting);
            //filterSettingPanel.addEventListener(JupiterConstants.GLC_GET, getGLC);
            //filterSettingPanel.addEventListener(JupiterConstants.GET_CASHFLOW_CATEGORY_TREE, getCashflowCategoryTree);
            //filterSettingPanel.addEventListener(JupiterConstants.GET_CASHFLOW_CATEGORY_LIST, getCashflowCategoryListHandler);
            
            filterSettingPanel.criteriaValueView.addEventListener(GetFieldDataSource.GET_FIELD_DATASOURCE, getFieldDataSource);
            
            getRuleList();
        }
        
        private function getFieldDataSource(event : GetFieldDataSource) : void
        {
        	switch(event.fieldName)
        	{
        		case "Currency":
        			getCurrency(); 
        			break;
        		case "Country":
        			getCountry();
        			break;
        		case "InstitutionCode":
        			getInstitution();
        			break;
        		case "CashflowCategoryID":
        			getCashflowCategoryListHandler();
        			break;
        		case "IndustryCode":
        			getIndustryTree();
        			break;
        		case "GLC1":
                    getGLC("GLC1");
                    break;
                case "GLC2":
                    getGLC("GLC2");
                    break;
                case "GLC3":
                	getGLC("GLC3");
                    break;
                case "GLC4":
                	getGLC("GLC4");
                    break;
        	}
        }
        
        private function getRuleList():void
        {
        	if(scenarioProxy.scenarioRuleList)
        	{
        		createRuleButton(scenarioProxy.scenarioRuleList);
        	}
        	else
        	{
        		
        	}
        }
        
        private function createRuleButton(ac:ArrayCollection):void
        {        	
        	if(ac)
        	{
        		for each(var vo:ScenarioRule in ac)
        		{
        			var rb:RadioButton = new RadioButton();
        			rb.id = vo.ruleId.toString();
        			rb.groupName = "RBGRule";
        			rb.label = vo.ruleName;
        			rb.value = vo.ruleClass;
        			
        			if(rb.id == filterSettingPanel.selectedRuleID.toString())
        			rb.selected = true;
        			
        			filterSettingPanel.ruleHBox.addChild(rb);
        		}
        	
        		
        	}
                        		
        }

        private function getGLC(glcName : String):void
        {
            if (glcProxy.getData() != null)
            {
                var listCollection:XMLListCollection;
                var sourceXML:XML=glcProxy.getData() as XML;
                switch (glcName)
                {
                    case "GLC1":
                        listCollection=new XMLListCollection((sourceXML.children()[0] as XML).children());
                        break;
                    case "GLC2":
                        listCollection=new XMLListCollection((sourceXML.children()[1] as XML).children());
                        break;
                    case "GLC3":
                        listCollection=new XMLListCollection((sourceXML.children()[2] as XML).children());
                        break;
                    case "GLC4":
                        listCollection=new XMLListCollection((sourceXML.children()[3] as XML).children());
                        break;
                }
                filterSettingPanel.criteriaValueView.setFieldDataSource(glcName, listCollection);
                /* filterSettingPanel.filterValueGLC.dataProvider=listCollection;
                filterSettingPanel.vs.selectedIndex=4; */
            }
            else
            {
                glcProxy.getGLCs();
            }

        }
        
        private function getCashflowCategoryTree(event : Event) : void
        {
        	if(cashflowCategoryProxy.cashflowCategoriesXML != null)
        	{
        		var listCollection:XMLListCollection=new XMLListCollection((cashflowCategoryProxy.cashflowCategoriesXML as XML).children());
                    filterSettingPanel.filterValueGLC.dataProvider=listCollection;
                    filterSettingPanel.vs.selectedIndex=4;
        	}
        	else        	
            cashflowCategoryProxy.getCashflowCategoriesXML();
        }
        
        private function getCashflowCategoryListHandler():void
        {
        	if(cashflowCategoryProxy.getData() != null)
        	{
        		/* filterSettingPanel.filterValueList.listDP = cashflowCategoryProxy.cashflowCategoryListDP ;
                filterSettingPanel.filterValueList.listDP.refresh();
                filterSettingPanel.vs.selectedIndex = 0;
                filterSettingPanel.filterValueList.list.selectedIndex = 0; */
                
                filterSettingPanel.criteriaValueView.setFieldDataSource("CashflowCategoryID", cashflowCategoryProxy.cashflowCategoryListDP);
        	}
        	else
        	{
        		cashflowCategoryProxy.getCashflowCategoriesList();
        	}
        }

        private function saveFilterSetting(evt:Event):void
        {
            var arr:Array=new Array();
            arr.push(filterSettingPanel.sqlListDP);
            var vo:ScenarioRule = new ScenarioRule();
            vo.ruleId = Number((filterSettingPanel.RBGRule.selection as RadioButton).id);
            vo.ruleName = (filterSettingPanel.RBGRule.selection as RadioButton).label;
            vo.ruleClass = (filterSettingPanel.RBGRule.selection as RadioButton).value.toString();
            arr.push(vo);
            if (filterSettingPanel.isUpdate)
            {
                sendNotification(JupiterConstants.SQLLIST_CHANGED, arr, "update");
            }
            else
            {
                sendNotification(JupiterConstants.SQLLIST_CHANGED, arr, "add");
            }

        }

        private function getRegion(evt:Event):void
        {
            if (regionProxy.regioncodeDP.length > 0)
            {
                filterSettingPanel.filterValueList.listDP=regionProxy.regioncodeDP;
                filterSettingPanel.vs.selectedIndex=0;
                filterSettingPanel.filterValueList.list.selectedIndex=0;
            }
            else
            {
                regionProxy.getRegion();
            }
        }

        private function getIndustry(evt:Event):void
        {
            if (industryProxy.industryCodeDP.length > 0)
            {
                /* filterSettingPanel.filterValueList.listDP=industryProxy.industryCodeDP;
                filterSettingPanel.vs.selectedIndex=0;
                filterSettingPanel.filterValueList.list.selectedIndex=0; */
                filterSettingPanel.criteriaValueView.setFieldDataSource("IndustryCode", industryProxy.industryCodeDP);
            }
            else
            {
                industryProxy.getIndustry();
            } 
        }
        private function getIndustryTree() : void
        {
        	if(industryProxy.industryTree != null)
        	{
        		var listCollection:XMLListCollection=new XMLListCollection((industryProxy.industryTree).children());
                /*     filterSettingPanel.filterValueGLC.dataProvider=listCollection;
                    filterSettingPanel.vs.selectedIndex=4; */
                    
                filterSettingPanel.criteriaValueView.setFieldDataSource("IndustryCode", listCollection);
        	}
        	else
        	{
        		industryProxy.getIndustryTreeXML();
        	}    
        }

        private function getInstitution():void
        {
            if (institutionProxy.institutionCodeDP.length > 0)
            {
                /* filterSettingPanel.filterValueList.listDP=institutionProxy.institutionCodeDP;
                filterSettingPanel.vs.selectedIndex=0;
                filterSettingPanel.filterValueList.list.selectedIndex=0; */
                
                filterSettingPanel.criteriaValueView.setFieldDataSource("InstitutionCode", institutionProxy.institutionCodeDP);
            }
            else
            {
                institutionProxy.getInstitution();
            }
        }


        private function getCurrency():void
        {
            if (currencyproxy.currencyCodeDP.length > 0)
            {
                /* filterSettingPanel.filterValueList.listDP=currencyproxy.currencyCodeDP;
                filterSettingPanel.vs.selectedIndex=0;
                filterSettingPanel.filterValueList.list.selectedIndex=0; */
                filterSettingPanel.criteriaValueView.setFieldDataSource("Currency", currencyproxy.currencyCodeDP);
            }
            else
            {
                sendNotification(ApplicationFacade.CURRENCY_GET);
            }
        }

        private function getCountry():void
        {
            if (countryproxy.countrycodeDP.length > 0)
            {
                /* filterSettingPanel.filterValueList.listDP=countryproxy.countrycodeDP;
                filterSettingPanel.vs.selectedIndex=0;
                filterSettingPanel.filterValueList.list.selectedIndex=0; */
                filterSettingPanel.criteriaValueView.setFieldDataSource("Country", countryproxy.countrycodeDP);
            }
            else
            {
                sendNotification(ApplicationFacade.COUNTRY_GET);
            }
        }

        override public function listNotificationInterests():Array
        {
            return [ApplicationFacade.CURRENCY_LOAD_SUCCESS,
                ApplicationFacade.COUNTRY_LOAD_SUCCESS,
                ApplicationFacade.INDUSTRY_LOAD_SUCCESS,
                ApplicationFacade.INSTITUTION_LOAD_SUCCESS,
                ApplicationFacade.REGION_LOAD_SUCCESS,
                ApplicationFacade.GLC_LOAD_SUCCESS,
//                ApplicationFacade.CASHFLOW_CATEGORIES_XML_LOAD_SUCCESS
				ApplicationFacade.CASHFLOW_CATEGORIES_LIST_LOAD_SUCCESS,
				ApplicationFacade.INDUSTRY_TREE_LOAD_SUCCESS];
        }

        override public function handleNotification(notification:INotification):void
        {
            switch (notification.getName())
            {
                case ApplicationFacade.CURRENCY_LOAD_SUCCESS:
                    /* filterSettingPanel.filterValueList.listDP=currencyproxy.currencyCodeDP;
                    filterSettingPanel.filterValueList.listDP.refresh();
                    filterSettingPanel.vs.selectedIndex=0;
                    filterSettingPanel.filterValueList.list.selectedIndex=0; */
                    filterSettingPanel.criteriaValueView.setFieldDataSource("Currency", currencyproxy.currencyCodeDP);
                    break;
                case ApplicationFacade.COUNTRY_LOAD_SUCCESS:
                    /* filterSettingPanel.filterValueList.listDP=countryproxy.countrycodeDP;
                    filterSettingPanel.filterValueList.listDP.refresh();
                    filterSettingPanel.vs.selectedIndex=0;
                    filterSettingPanel.filterValueList.list.selectedIndex=0; */
                    filterSettingPanel.criteriaValueView.setFieldDataSource("Country", countryproxy.countrycodeDP);
                    break;
                case ApplicationFacade.INDUSTRY_LOAD_SUCCESS:
                    /* filterSettingPanel.filterValueList.listDP=industryProxy.industryCodeDP;
                    filterSettingPanel.filterValueList.listDP.refresh();
                    filterSettingPanel.vs.selectedIndex=0;
                    filterSettingPanel.filterValueList.list.selectedIndex=0; */
                    filterSettingPanel.criteriaValueView.setFieldDataSource("IndustryCode", industryProxy.industryCodeDP);
                    break;
                case ApplicationFacade.INSTITUTION_LOAD_SUCCESS:
                    /* filterSettingPanel.filterValueList.listDP=institutionProxy.institutionCodeDP;
                    filterSettingPanel.filterValueList.listDP.refresh();
                    filterSettingPanel.vs.selectedIndex=0;
                    filterSettingPanel.filterValueList.list.selectedIndex=0; */
                    filterSettingPanel.criteriaValueView.setFieldDataSource("InstitutionCode", institutionProxy.institutionCodeDP);
                    break;
                case ApplicationFacade.REGION_LOAD_SUCCESS:
                    /* filterSettingPanel.filterValueList.listDP=regionProxy.regioncodeDP;
                    filterSettingPanel.filterValueList.listDP.refresh();
                    filterSettingPanel.vs.selectedIndex=0;
                    filterSettingPanel.filterValueList.list.selectedIndex=0; */
                    
                    break;
                case ApplicationFacade.GLC_LOAD_SUCCESS:
                    /* var listCollection:XMLListCollection=new XMLListCollection(((glcProxy.getData() as XML).children()[0] as XML).children());
                    filterSettingPanel.filterValueGLC.dataProvider=listCollection;
                    filterSettingPanel.vs.selectedIndex=4; */
                    var listCollection:XMLListCollection=new XMLListCollection(((glcProxy.getData() as XML).children()[0] as XML).children());
                    filterSettingPanel.criteriaValueView.setFieldDataSource("GLC1", listCollection);
                    break;
                case ApplicationFacade.CASHFLOW_CATEGORIES_LIST_LOAD_SUCCESS:
                    /* filterSettingPanel.filterValueList.listDP = cashflowCategoryProxy.cashflowCategoryListDP;
                    filterSettingPanel.filterValueList.listDP.refresh();
                    filterSettingPanel.vs.selectedIndex = 0;
                    filterSettingPanel.filterValueList.list.selectedIndex = 0; */
                    filterSettingPanel.criteriaValueView.setFieldDataSource("CashflowCategoryID", cashflowCategoryProxy.cashflowCategoryListDP);
                    break;
                    
                case ApplicationFacade.INDUSTRY_TREE_LOAD_SUCCESS:
                	/* var listCollection:XMLListCollection=new XMLListCollection(industryProxy.industryTree.children());
                    filterSettingPanel.filterValueGLC.dataProvider=listCollection;
                    filterSettingPanel.vs.selectedIndex=4; */
                    var listCollection:XMLListCollection=new XMLListCollection(industryProxy.industryTree.children());
                    filterSettingPanel.criteriaValueView.setFieldDataSource("IndustryCode", listCollection);
                    break;
/*                 case ApplicationFacade.CASHFLOW_CATEGORIES_XML_LOAD_SUCCESS:
                    var listCollection:XMLListCollection=new XMLListCollection((cashflowCategoryProxy.cashflowCategoriesXML as XML).children());
                    filterSettingPanel.filterValueGLC.dataProvider=listCollection;
                    filterSettingPanel.vs.selectedIndex=4;
                    break; */
            }
        }

        public function get filterSettingPanel():FilterSettingPanel
        {
            return viewComponent as FilterSettingPanel;
        }

    }
}