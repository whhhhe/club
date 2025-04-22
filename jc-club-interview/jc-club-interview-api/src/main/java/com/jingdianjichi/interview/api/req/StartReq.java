package com.jingdianjichi.interview.api.req;

import com.jingdianjichi.interview.api.enums.EngineEnum;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.List;
import java.util.Objects;


@Getter
@Setter
public class StartReq implements Serializable {

    private String engine = EngineEnum.ALI_BL.name();

    private List<Key> questionList;

    @Data
    public static class Key {
        private String keyWord;
        private Long categoryId;
        private Long labelId;

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            Key key = (Key) o;
            return Objects.equals(keyWord, key.keyWord) && Objects.equals(categoryId, key.categoryId) && Objects.equals(labelId, key.labelId);
        }

        @Override
        public int hashCode() {
            return Objects.hash(keyWord, categoryId, labelId);
        }
    }

}
