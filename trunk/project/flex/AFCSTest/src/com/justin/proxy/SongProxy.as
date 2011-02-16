package com.justin.proxy
{
    import com.justin.service.ServiceConstants;

    public class SongProxy extends BaseProxy
    {
        private static var songProxy:SongProxy;
        public function SongProxy()
        {
            destination = ServiceConstants.SONGSERVICE;
            super();

            if(songProxy != null)
                throw new Error("SongProxy only create once.");
        }

        public static function getInstance():SongProxy
        {
            if(songProxy)
            {
                return songProxy;
            }
            else
            {
                songProxy = new SongProxy();
                return songProxy;
            }
        }
    }
}