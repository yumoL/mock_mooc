package com.course.business.controller.admin;

import com.course.server.dto.CourseDto;
import com.course.server.dto.PageDto;
import com.course.server.dto.ResponseDto;
import com.course.server.service.CourseService;
import com.course.server.util.ValidatorUtil;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/admin/course")
public class CourseController {

    public static final String BUSINESS_NAME = "course";

    @Resource
    private CourseService courseService;

    @PostMapping("/list")
    public ResponseDto list(@RequestBody PageDto pageDto) {
        ResponseDto responseDto = new ResponseDto();
        courseService.list(pageDto);
        responseDto.setContent(pageDto);
        return responseDto;
    }

    @PostMapping("/save")
    public ResponseDto save(@RequestBody CourseDto courseDto) {
        //validation
        ValidatorUtil.require(courseDto.getName(), "name");
        ValidatorUtil.length(courseDto.getName(), "name", 1, 50);
        ValidatorUtil.length(courseDto.getSummary(), "summary", 1, 2000);
        ValidatorUtil.length(courseDto.getImage(), "image", 1, 100);

        ResponseDto responseDto = new ResponseDto();
        courseService.save(courseDto);
        responseDto.setContent(courseDto);
        return responseDto;
    }

    @DeleteMapping("/delete/{id}")
    public ResponseDto delete(@PathVariable String id) {
        ResponseDto responseDto = new ResponseDto();
        courseService.delete(id);
        return responseDto;
    }
}