using System.ComponentModel;
using System.Globalization;

namespace Hero.Server.Core.Extensions
{
    public class Convert
    {
        public static T To<T>(object value)
        {
            T result = default;
            if (null != value)
            {
                if (value is T variable1)
                {
                    result = variable1;
                }
                else
                {
                    object obj = To(typeof(T), value);
                    if (obj is T variable)
                    {
                        result = variable;
                    }
                }
            }
            return result;
        }

        public static object To(Type type, object value)
        {
            object result = null;
            if (null != value)
            {
                Type valueType = value.GetType();
                if (type == valueType ||
                    type.IsAssignableFrom(valueType))
                {
                    result = value;
                }
                else if (valueType == typeof(string) && type == typeof(Type))
                {
                    result = Type.GetType((string)value);
                }
                else if (type.IsEnum &&
                    Enum.IsDefined(type, value))
                {
                    if (value is string s)
                    {
                        try
                        {
                            result = Enum.Parse(type, s);
                        }
                        catch (ArgumentException) { }
                    }
                    else
                    {
                        try
                        {
                            result = Enum.ToObject(type, value);
                        }
                        catch (ArgumentException) { }
                    }
                }
                else if (value is string s &&
                    s.ToUpper(CultureInfo.InvariantCulture).Equals("NULL", StringComparison.Ordinal))
                {
                    result = null;
                }
                //convert the value
                else
                {
                    TypeConverter converter = TypeDescriptor.GetConverter(type);
                    if (null != converter &&
                        converter.CanConvertFrom(valueType))
                    {
                        try
                        {
                            result = converter.ConvertFrom(value);
                        }
                        catch (Exception)
                        {
                            // ignored
                        }
                    }
                }
            }

            return result;
        }
    }
}
