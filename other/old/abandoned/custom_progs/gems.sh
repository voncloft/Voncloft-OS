for f in /Voncloft-OS/ruby-gems/*;
do
	gem=${f##*/};
	final=${gem#ruby-}
	sh /Voncloft-OS/utilities/bin/gems.sh $final
done;
