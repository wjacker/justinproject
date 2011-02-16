package com.justin.vo
{
    [RemoteClass(alias="com.justin.project.database.dao.Song")]
    public class Song
    {
        public function Song()
        {
        }
        public var url:String;
        public var author:String;
        public var playOrder:String;
    }
}