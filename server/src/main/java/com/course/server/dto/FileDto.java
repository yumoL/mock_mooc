package com.course.server.dto;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class FileDto {
    private String id;
    private String path;
    private String name;
    private String suffix;
    private Integer size;
    private String use;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+2")
    private Date createdAt;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+2")
    private Date updatedAt;

    private Integer shardIndex;

    private Integer shardSize;

    private Integer shardTotal;

    private String key;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSuffix() {
        return suffix;
    }

    public void setSuffix(String suffix) {
        this.suffix = suffix;
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public String getUse() {
        return use;
    }

    public void setUse(String use) {
        this.use = use;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Integer getShardIndex() {
        return shardIndex;
    }

    public void setShardIndex(Integer shardIndex) {
        this.shardIndex = shardIndex;
    }

    public Integer getShardSize() {
        return shardSize;
    }

    public void setShardSize(Integer shardSize) {
        this.shardSize = shardSize;
    }

    public Integer getShardTotal() {
        return shardTotal;
    }

    public void setShardTotal(Integer shardTotal) {
        this.shardTotal = shardTotal;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    @Override
    public String toString() {
        return "FileDto{" +
                "id='" + id + '\'' +
                ", path='" + path + '\'' +
                ", name='" + name + '\'' +
                ", suffix='" + suffix + '\'' +
                ", size=" + size +
                ", use='" + use + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", shardIndex=" + shardIndex +
                ", shardSize=" + shardSize +
                ", shardTotal=" + shardTotal +
                ", key='" + key + '\'' +
                '}';
    }
}
