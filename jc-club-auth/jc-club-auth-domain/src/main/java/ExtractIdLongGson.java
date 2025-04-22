import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ExtractIdLongGson {

    public static Long extractIdFromJson(String json) {
        Gson gson = new Gson();
        Type listType = new TypeToken<java.util.List<Map<String, Object>>>() {}.getType();
        java.util.List<Map<String, Object>> dataList = gson.fromJson(json, listType);

        if (!dataList.isEmpty()) {
            Map<String, Object> data = dataList.get(0);
            if (data.containsKey("id")) {
                Object idValue = data.get("id");
                if (idValue instanceof Number) {
                    return ((Number) idValue).longValue();
                }
            }
        }
        return null;
    }


    public static void main(String[] args) {
        String json = "[{\"id\":1,\"roleName\":\"管理员\",\"roleKey\":\"admin_user\",\"createdBy\":\"oYA4HtwGJEsLio6pGrhx5Hzv9XD0\",\"createdTime\":\"Feb 28, 2024 3:20:44 AM\",\"updateBy\":\"\",\"updateTime\":\"Nov 12, 2023 4:16:07 PM\",\"isDeleted\":0}]";
        Long id  = extractIdFromJson(json);
        System.out.println("id 值为: " + id);

    }
}    