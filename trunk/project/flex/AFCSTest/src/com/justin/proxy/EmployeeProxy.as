package com.justin.proxy
{
    import com.justin.common.components.datagrid.Pager;
    import com.justin.service.ServiceConstants;

    public class EmployeeProxy extends BaseProxy
    {
        private static var employeeProxy:EmployeeProxy;
        public function EmployeeProxy()
        {
            destination = ServiceConstants.EMPLOYEESERVICE;
            super();

            if(employeeProxy != null)
                throw new Error("EmployeeProxy only create once.");
        }

        public static function getInstance():EmployeeProxy
        {
            if(employeeProxy)
            {
                return employeeProxy;
            }
            else
            {
                employeeProxy = new EmployeeProxy();
                return employeeProxy;
            }
        }
    }
}